program main
    use functions
    use integration
    use legendre_polynomial
    implicit none
    integer :: p  ! polynomial degree
    real(kind=8) :: a = 0.0  ! integration interval
    real(kind=8) :: b = 10.0
    real(kind=8) :: r  ! rectangular intergration
    real(kind=8) :: t  ! trapezoidal intergration
    real(kind=8) :: g  ! gaussian quadrature
    ! character(50) :: format1
    real(kind=8) :: true_values(10)

   ! format1 = "(F10.6)"
    write(*,*) "Interval: a =", a, " and b =", b
    write(*,*)

    r = rectangular_integration(a, b, my_exp, 0)
    t = trapezoidal_integration(a, b, my_exp, 0)
    write(*,*) "exp(x):"
    write(*,*) "real value:    22025.465795"
    write(*,*) "rectangular:", r, "difference:", abs(r-22025.465795)
    write(*,*) "trapezoidal:", t, "difference:", abs(t-22025.465795)
    write(*,*)

    r = rectangular_integration(a, b, my_sin, 0)
    t = trapezoidal_integration(a, b, my_sin, 0)
    write(*,*) "sin(x):"
    write(*,*) "real value:    1.839072"
    write(*,*) "rectangular:", r, "difference:", abs(r-1.839072)
    write(*,*) "trapezoidal:", t, "difference:", abs(r-1.839072)
    write(*,*)

    true_values = [5D1, 3.33333333D2, 2.500D3, 2D4, 1.66667D5, 1.428571D6, 1.25D7, 1.11111111D8, 1D9, 9.090909091D9]
    do p=1, 10
        r = rectangular_integration(a, b, my_pol, p)
        t = trapezoidal_integration(a, b, my_pol, p)
        write(*,*) "W(x)=x^", p
        write(*,*) "real value:", true_values(p)
        write(*,*) "rectangular: ", r, "difference:", abs(r-true_values(p))
        write(*,*) "trapezoidal: ", t, "difference:", abs(r-true_values(p))
        write(*,*)
    end do



end program
