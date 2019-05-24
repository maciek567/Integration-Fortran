program main
    use fftw
    implicit none

    real, parameter :: PI = 3.1415926
    integer :: fs  ! sampling frequency
    integer :: fc  ! cosine frequency
    integer :: N  ! number of samples
    integer :: i  ! loop iteration
    real(kind=4) :: r  ! random number
    real(kind=4) :: time  ! current time point
    real(kind=4) :: difference  ! time interval added to time in each loop iteration
    real(kind=4), allocatable, dimension(:) :: T  ! time points vector

    fs = 1024
    fc = 20
    N = 1024
    time = 0.0
    difference = 1.0 / (fs-1)

    allocate (T(N))
    open(1, file = "../res/cos.txt", status = 'replace')
    open(2, file = "../res/cos_rand.txt", status = 'replace')

    do i = 1,N
        time = time + difference
        write(1,*) cos(2*PI*time*fc)

        call random_number(r)
        write(2,*) cos(2*PI*time*fc) + r
        T(i) = cos(2*PI*time*fc) + r
    end do

    write(*,*) T
    if(allocated(T)) deallocate(T)
    close(1)
    close(2)



end program
