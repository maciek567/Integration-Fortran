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

    function trapezoidal_integration(ibeg, iend, myfun, k) result(value)
        implicit none
        real(kind=8), intent(in) :: ibeg  ! beginning of integration interval
        real(kind=8), intent(in) :: iend  ! ending of integration interval
        real(kind=8), external :: myfun  ! function to be integrated
        integer(kind=4), intent(in) :: k  ! divide area to k trapezoids
        real(kind=8) :: value  ! result of integration
        real(kind=8) :: diff  ! height of a single trapezoid
        real(kind=8) :: x  ! loop iterator

        value = 0.0
        diff = (iend - ibeg) / k
        do x=ibeg, iend-diff, diff
            ! write(*,*) value
            value = value + (myfun(x) + myfun(x+diff)) * (diff/2.0)
        end do
    end function

end module
