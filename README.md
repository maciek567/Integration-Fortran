# Fortran - Task 3

## Zawartość projektu

Wszystkie pliki źródłowe znajdują sie w katalogu src. Plik **integration.f90** przedstawia funkcje umożliwiające całkowanie metodą prostokątów i trapezów. Plik **functions.f90** zawiera 3 przykładowe funkcje testowe (exp(x), sin(x) i wielomian W(x)), a **main.f90** wywołuje powyższe funkcje i porównuje z wartościami rzeczywistymi.
Katalog **res** posiada natomiast uzyskane wyniki.

## Sprawozdanie
Pierwszym krokiem była implementacja interfejsu. Po wielu próbach uruchomienia zdecydowałem sie na zamianę **procedure (funint) :: myfun** na **real(kind=8), external :: myfun**, co umożliwiło mi kompilację programu. Następnie napisałem funkcje odpowiedzialne za proste całkowanie metodami prostokątów i trapezów, a także przetestowałem je za pomocą funkcji sin(x) i exp(x) w przdziale 0 do 10. W dalszej kolejności dodałem obsługę wielomianów oraz porównanie uzyskanych wartości z rzeczywistymi. Ostatnim krokiem było podzielenia obliczanych fragmentów pola między różne procesy dzięki wprowadzeniu coarrays.

## Obserwacje i wnioski
Większość testów wykazała lepsze zachowanie metody prostokątów od trapezów (błąd mniejszy mniej więcej dwukrotnie). Wyjątkiem było pole pod funkcją liniową, gdzie obie metody poradziły sobie identycznie. Zgodnie z przwidywaniami błąd zwiększał się w miarę wzrostu pola do policzenia, co jest zgodnie z zachowaniem liczb zmiennoprzecinkowych.
