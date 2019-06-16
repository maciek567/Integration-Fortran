module integration
    implicit none

    interface
        function integrate(ibeg, iend, myfun, p) result(value)
            implicit none
            real(kind=8), intent(in) :: ibeg  ! beginning of integration interval
            real(kind=8), intent(in) :: iend  ! ending of integration interval
            real(kind=8), external :: myfun  ! function to be integrated
            integer(kind=4), intent(in) :: p  ! polynomial order
            real(kind=8) :: value  ! result of integration
        end function integrate
    end interface

contains

function rectangular_integration(ibeg, iend, myfun, p) result(valu)
        implicit none
        real(kind=8), intent(in) :: ibeg  ! beginning of integration interval
        real(kind=8), intent(in) :: iend  ! ending of integration interval
        real(kind=8), external :: myfun  ! function to be integrated
        integer(kind=4), intent(in) :: p  ! polynomial order
        real(kind=8) :: valu  ! result of integration
        real(kind=8), codimension[*], save :: value  ! result of integration
        real(kind=8) :: diff  ! height of a single trapezoid
        real(kind=8) :: x  ! loop iterator
        integer :: k  ! divide area to k trapezoids
        integer :: i, istart, istop  ! coarrays

        syncall()

        value = 0.0
        k = 1000
        diff = (iend - ibeg) / k
        istart= ibeg + (this_image() - 1) * ((iend - ibeg) / num_images()) + 1
        istop = ibeg + (this_image() * ((iend - ibeg) / num_images()))

        do x=istart, istop-diff, diff
            ! write(*,*) value
            value = value + myfun(x+diff/2.0, p) * diff
        end do

        syncall()

        if(this_image() == 1) then
            do i=1, num_images()
                value = value + value[i]
            end do
        endif
        if(this_image() == 1) then
            do i=1, num_images()
                value[i] = value
            end do
        endif
        valu=value
    end function

    function trapezoidal_integration(ibeg, iend, myfun, p) result(valu)
        implicit none
        real(kind=8), intent(in) :: ibeg  ! beginning of integration interval
        real(kind=8), intent(in) :: iend  ! ending of integration interval
        real(kind=8), external :: myfun  ! function to be integrated
        integer(kind=4), intent(in) :: p  ! polynomial order
        real(kind=8):: valu  ! result of integration
        real(kind=8), codimension[*], save  :: value  ! result of integration
        real(kind=8) :: diff  ! height of a single trapezoid
        real(kind=8) :: x  ! loop iterator
        integer :: k  ! divide area to k trapezoids
        integer :: i, istart, istop  ! coarrays

        syncall()

        value = 0.0
        k = 1000
        diff = (iend - ibeg) / k
        istart= ibeg + (this_image() - 1) * ((iend - ibeg) / num_images()) + 1
        istop = ibeg + (this_image() * ((iend - ibeg) / num_images()))

        do x=istart, istop-diff, diff
            ! write(*,*) value
            value = value + (myfun(x, p) + myfun(x+diff, p)) * (diff/2.0)
        end do

        syncall()

        if(this_image() == 1) then
            do i=1, num_images()
                value = value + value[i]
            end do
        endif
        if(this_image() == 1) then
            do i=1, num_images()
                value[i] = value
            end do
        endif
        valu=value
end function

    recursive function legendre(k, x)
        implicit none
        integer :: k
        real(kind=8), intent(in) :: x
        real(kind=8) legendre

        if (k .EQ. 0) then
            legendre = 1
        else if (k .EQ. 1) then
            legendre = x
        else
            legendre = ((2*k - 1) / k) * x * legendre(k-1, x) - ((k-1) / k) * legendre(k-2, x)
        end if
    end function

end module
