# Backend Authentication Service

Serwer autentykacji oparty na gRPC i FastAPI.

## Wymagania

- Python 3.8+
- Redis (serwer Redis Cloud)
- Virtualenv (opcjonalnie)

## Instalacja

1. Stwórz i aktywuj wirtualne środowisko (opcjonalnie):
```bash
python -m venv venv
source venv/bin/activate  # Linux/macOS
venv\Scripts\activate     # Windows
```

2. Zainstaluj zależności:
```bash
pip install -r requirements.txt
```

## Uruchamianie

Możesz uruchomić wszystkie komponenty za pomocą jednego polecenia:

```bash
python run_all.py
```

Ten skrypt:
1. Zatrzyma wszystkie istniejące procesy Python
2. Uruchomi serwer gRPC
3. Uruchomi testy automatyczne
4. Uruchomi serwer FastAPI

## Struktura projektu

```
backend/
├── app/
│   ├── api/            # Implementacja gRPC i FastAPI
│   ├── core/           # Konfiguracja i bezpieczeństwo
│   └── db/            # Obsługa bazy danych Redis
├── protos/           # Definicje protokołu gRPC
├── main.py          # Główny plik FastAPI
├── run_grpc.py      # Skrypt uruchamiający serwer gRPC
├── run_all.py       # Skrypt uruchamiający wszystkie komponenty
├── test_server.py   # Testy serwera gRPC
└── requirements.txt # Zależności projektu
```

## Endpointy

### gRPC (port 50051)
- Register - rejestracja nowego użytkownika
- Login - logowanie użytkownika
- ValidateToken - walidacja tokenu JWT

### FastAPI (port 8000)
- GET / - sprawdzenie statusu serwera

## Testowanie

Testy są uruchamiane automatycznie przy starcie przez `run_all.py`. 
Możesz też uruchomić je osobno:

```bash
python test_server.py
``` 