SINE=sines_sum
NOISE=fft_noise
FLAGS=-Ldirectory -lfftw3 -check bounds -std08 -implicitnone

all: sine run_sine noise run_noise

sine:
	ifort $(SINE).f90 -o $(SINE) $(FLAGS)
run_sine:
	./$(SINE)

noise:
	ifort $(NOISE).f90 -o $(NOISE) $(FLAGS)
run_noise:
	./$(NOISE)
clean:
	rm -rf $(SINE) $(NOISE)

