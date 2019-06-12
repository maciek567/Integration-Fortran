program main
    use functions
    use integration
    implicit none
    integer :: i
    real(kind=8) :: a = 0.0
    real(kind=8) :: b = 10.0
    integer(kind=4) :: k = 1000
    real(kind=8) :: r


    r = trapezoidal_integration(a, b, my_exp, k)
    write(*,*) r

    r = trapezoidal_integration(a, b, my_sin, k)
    write(*,*) r


end program
