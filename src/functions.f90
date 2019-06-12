module functions
    implicit none

    interface
        module function fun_int(x) result(y)
            implicit none
            real(kind=8), intent(in) :: x
            real(kind=8) :: y
        end function
    end interface

contains

    function my_exp(x) result(y)
        implicit none
        real(kind=8), intent(in) :: x
        real(kind=8) :: y
        y = exp(x)
    end function

    function my_sin(x) result(y)
        implicit none
        real(kind=8), intent(in) :: x
        real(kind=8) :: y
        y = sin(x)
    end function

    function my_pol(x, p) result(y)
        implicit none
        real(kind=8), intent(in) :: x
        integer :: p  ! polynomial degree
        real(kind=8) :: y
        y = x ** p
    end function

end module
