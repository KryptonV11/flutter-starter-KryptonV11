# Geo Journal (Flutter)

## Cel projektu
Celem projektu było stworzenie mobilnej aplikacji w technologii Flutter,
wykorzystującej natywną funkcję urządzenia mobilnego oraz komunikację z API.

Aplikacja umożliwia dodawanie wpisów dziennika wraz z lokalizacją GPS
oraz ich przeglądanie w postaci listy i szczegółów.

---

## Zakres funkcjonalny

Aplikacja zawiera 4 widoki:
- widok listy wpisów
- widok szczegółów wpisu
- widok dodawania nowego wpisu (formularz)
- widok ustawień aplikacji (zmiana motywu)

Pomiędzy widokami zaimplementowano nawigację z przekazywaniem identyfikatora wpisu.

---

## Funkcja natywna
Zastosowaną funkcją natywną jest lokalizacja GPS:
- pobieranie aktualnej pozycji użytkownika
- obsługa uprawnień lokalizacyjnych

Funkcja ta pozwala powiązać wpis dziennika z konkretnym miejscem.

---

## Komunikacja z API
Aplikacja komunikuje się z zewnętrznym API:
- GET – pobranie listy wpisów
- POST – zapis nowego wpisu

W projekcie wykorzystano testowe API:
https://jsonplaceholder.typicode.com

---

## UX i obsługa stanów
Zaimplementowano:
- stan ładowania danych
- obsługę błędów sieciowych
- pusty stan listy
- komunikaty dla użytkownika (SnackBar)

---

## Technologie
- Flutter (Dart)
- Provider (zarządzanie stanem)
- HTTP
- Geolocator
- Android Studio, Emulator Android

---

## Testowanie
Aplikacja była uruchamiana i testowana lokalnie na emulatorze Android.
Przetestowano:
- dodawanie wpisu z lokalizacją GPS
- komunikację z API
- zachowanie aplikacji przy braku danych

---

## Uruchomienie projektu
```bash
flutter pub get
flutter run
