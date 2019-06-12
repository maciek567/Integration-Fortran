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

    function rectangular_integration(ibeg, iend, myfun, p) result(value)
        implicit none
        real(kind=8), intent(in) :: ibeg  ! beginning of integration interval
        real(kind=8), intent(in) :: iend  ! ending of integration interval
        real(kind=8), external :: myfun  ! function to be integrated
        integer(kind=4), intent(in) :: p  ! polynomial order
        real(kind=8) :: value  ! result of integration
        real(kind=8) :: diff  ! height of a single trapezoid
        real(kind=8) :: x  ! loop iterator
        integer :: k  ! divide area to k trapezoids

        value = 0.0
        k = 1000
        diff = (iend - ibeg) / k
        do x=ibeg, iend-diff, diff
            ! write(*,*) value
            value = value + myfun(x+diff/2.0, p) * diff
        end do
    end function

    function trapezoidal_integration(ibeg, iend, myfun, p) result(value)
        implicit none
        real(kind=8), intent(in) :: ibeg  ! beginning of integration interval
        real(kind=8), intent(in) :: iend  ! ending of integration interval
        real(kind=8), external :: myfun  ! function to be integrated
        integer(kind=4), intent(in) :: p  ! polynomial order
        real(kind=8) :: value  ! result of integration
        real(kind=8) :: diff  ! height of a single trapezoid
        real(kind=8) :: x  ! loop iterator
        integer :: k  ! divide area to k trapezoids

        value = 0.0
        k = 1000
        diff = (iend - ibeg) / k
        do x=ibeg, iend-diff, diff
            ! write(*,*) value
            value = value + (myfun(x, p) + myfun(x+diff, p)) * (diff/2.0)
        end do
    end function

end module