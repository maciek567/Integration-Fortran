NAME=main
FLAGS= -check bounds -implicitnone

all: compile run

compile:
	ifort functions.f90 integration.f90 $(NAME).f90 -o $(NAME) $(FLAGS)
run:
	./$(NAME)

clean:
	rm -rf $(NAME) *.mod

