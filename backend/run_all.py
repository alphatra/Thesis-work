import os
import uvicorn
from app.api.rest_api import app

def main():
    print("Zatrzymywanie istniejących procesów Python...")
    os.system("pkill -f python")

    print("Uruchamianie serwera REST API...")
    uvicorn.run(app, host="0.0.0.0", port=8000)

if __name__ == "__main__":
    main() 