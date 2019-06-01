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
    real(kind=8) :: time  ! current time point
    real(kind=8) :: difference  ! time interval added to time in each loop iteration
    real(kind=8) :: fvalue  ! function value

    type(c_ptr) :: plan_fft
    real(c_double), allocatable :: input(:)
    complex(c_double_complex), allocatable :: output(:)


    ! initialization
    fs = 1024
    ff = 200
    N = 1024
    time = 0.0
    difference = 1.0 / (fs-1)

    allocate(input(N))
    allocate(output(N/2 + 1))

    open(1, file = "../res/time.txt", status = 'replace')
    open(2, file = "../res/sines_sum.txt", status = 'replace')
    open(3, file = "../res/sines_fft.txt", status = 'replace')


    ! sines sum function
    do i=1, N
        time = time + difference
        fvalue = sin(2*PI * time * ff) + sin(2*PI * time * 2*ff)
        input(i) = fvalue
        write(1,*) time
        write(2,*) fvalue
    end do


    ! perform FFT
    plan_fft = fftw_plan_dft_r2c_1d(size(input), input, output, FFTW_ESTIMATE+FFTW_UNALIGNED)
    call fftw_execute_dft_r2c(plan_fft, input, output)

    do i=1, N/2+1
        fvalue = abs(output(i))
        write(3,*) fvalue
    end do


    ! clean up
    call fftw_destroy_plan(plan_fft)
    do i=1, 3
        close(i)
    end do

end program
