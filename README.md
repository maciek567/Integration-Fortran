# Fortran - Task 2

## Zawartość projektu
Wszystkie pliki źródłowe znajdują sie w katalogu src. Pierwsza część zadania realizuje plik **sines_sum.f90**, a drugą **fft_noise.f90**. Otrzymane dane i wykresy położone sa natomiast w folderze res.

## Uruchamianie
Aby zbudowac i uruchomić projekt należy z poziomu katalogu **src** wywołać komendę 
```
make all
```

## Sprawozdanie
## FFT - Przykład realizacji FFT na sumie sinusów

Dla funkcji:
**f(t)=sin(2πt*200)+2sin(2πt*400)**,
wygenerowano wartości dla 1024 próbek i otrzymano wykres:

![alt text](https://github.com/maciek567/FFT---Fortran/blob/master/res/sines_sum.png)

Następnie uruchomiono szybką transormację Fouriera i otrzymano wykres:

![alt text](https://github.com/maciek567/FFT---Fortran/blob/master/res/sines_fft.png)

Dzięki przekształceniu łatwo mozna na nim zauważyć dwie częstotliwości z pierwotnego sygnału sumy sinusów.

## Zastosowanie FFT do usuwania szumów
Punktem wyjścia jest funkcja cosinus:

![alt text](https://github.com/maciek567/FFT---Fortran/blob/master/res/cosine.png)

Do której dodano szum z wykorzystaniem procedury random_number():

![alt text](https://github.com/maciek567/FFT---Fortran/blob/master/res/cosine_rand.png)

Następnie wykonano na funkcji FFT:

![alt text](https://github.com/maciek567/FFT---Fortran/blob/master/res/cosine_fft.png)

oraz usunięto szum przez proste wycięcie wszystkich częstotliwości o amplitudzie mniejszych od 50 .

![alt text](https://github.com/maciek567/FFT---Fortran/blob/master/res/cosine_removed_noise.png)

W końcu dokonano odwrotnej transformaty, aby zobaczyć otzrymany efekt.

![alt text](https://github.com/maciek567/FFT---Fortran/blob/master/res/cosine_inverse.png)

Jak widać szum został z powodzeniem usunięty.
