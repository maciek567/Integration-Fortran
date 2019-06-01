SOURCE=fft_noise

all: fft run

fft:
	ifort $(SOURCE).f90 -o $(SOURCE) -Ldirectory -lfftw3
run:
	./$(SOURCE)
clean:
	rm -rf $(SOURCE)

