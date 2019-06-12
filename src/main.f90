program main
    use functions
    use integration
    implicit none
    integer :: p  ! polynomial degree
    real(kind=8) :: a = 0.0  ! integration interval
    real(kind=8) :: b = 10.0
    real(kind=8) :: r  ! rectangular intergration
    real(kind=8) :: t  ! trapezoidal intergration


    write(*,*) "Integral in interval: a=", a, " and b=", b

    r = rectangular_integration(a, b, my_exp, 0)
    t = trapezoidal_integration(a, b, my_exp, 0)
    write(*,*) "exp(x):"
    write(*,*) "rectangular:", r
    write(*,*) "trapezoidal:", t
    write(*,*) "real value:    22 025.465795"

    r = rectangular_integration(a, b, my_sin, 0)
    t = trapezoidal_integration(a, b, my_sin, 0)
    write(*,*) "sin(x):"
    write(*,*) "rectangular:", r
    write(*,*) "trapezoidal:", t
    write(*,*) "real value:    1.839072"

    do p=1, 10
        r = rectangular_integration(a, b, my_pol, p)
        t = trapezoidal_integration(a, b, my_pol, p)
        write(*,*) "W(x)=x^", p, ": rectangular: ", r, "trapezoidal: ", t
    end do

end program
