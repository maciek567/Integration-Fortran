program main
    use, intrinsic :: iso_c_binding
    implicit none
    include 'fftw3.f03'


    ! types declarations
    real, parameter :: PI = 3.1415926
    integer :: fs ! sampling frequency
    integer :: ff  ! function - sine frequency
    integer :: N  ! number of samples
    integer :: i  ! loop iteration
    real(kind=8) :: r  ! random number
    real(kind=8) :: time  ! current time point
    real(kind=8) :: difference  ! time interval added to time in each loop iteration
    real(kind=8) :: fvalue  ! function value

    type(c_ptr) :: plan_fft, plan_inverse
    real(c_double), allocatable :: input(:)
    complex(c_double_complex), allocatable :: output(:)


    ! initialization
    fs = 1024
    ff = 20
    N = 1024
    time = 0.0
    difference = 1.0 / (fs-1)

    allocate(input(N))
    allocate(output(N/2 + 1))

    open(1, file = "../res/time.txt", status = 'replace')
    open(2, file = "../res/sin.txt", status = 'replace')
    open(3, file = "../res/sin_rand.txt", status = 'replace')
    open(4, file = "../res/fft.txt", status = 'replace')
    open(5, file = "../res/removed_noise.txt", status = 'replace')
    open(6, file = "../res/fft_inverse.txt", status = 'replace')


    ! sinus function + noise
    do i=1, N
        time = time + difference
        fvalue = sin(2*PI * time * ff) + sin(2*PI * time * 2*ff)
        input(i) = fvalue
        write(1,*) time
        write(2,*) fvalue

        call random_number(r)
        write(3,*) fvalue + r - 0.5
    end do


    ! perform FFT
    plan_fft = fftw_plan_dft_r2c_1d(size(input), input, output, FFTW_ESTIMATE+FFTW_UNALIGNED)
    call fftw_execute_dft_r2c(plan_fft, input, output)

    do i=1, N/2+1
        fvalue = abs(output(i))
        if(fvalue .ne. fvalue) fvalue = 0.0
        write(4,*) fvalue
    end do


    ! remove noise from voice signal
    do i=1, N/2+1
        if(abs(output(i)) < 50) output(i) = 0.0
        write(5,*) i, abs(output(i))
    end do


    ! perform inverse FFT
    plan_inverse = fftw_plan_dft_c2r_1d(size(input), output, input, FFTW_ESTIMATE+FFTW_UNALIGNED)
    call fftw_execute_dft_c2r(plan_inverse, output, input)

    time = 0.0
    do i=1, N
        time = time + difference
        write(6,*) input(i) / N
    end do


    ! clean up
    call fftw_destroy_plan(plan_fft)
    call fftw_destroy_plan(plan_inverse)
    do i=1, 6
        close(i)
    end do

end program
