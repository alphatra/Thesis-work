from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import uuid
from app.core.security import verify_password, create_access_token, get_password_hash
from app.db.redis_client import redis_client
from app.core.config import settings

app = FastAPI()

# Konfiguracja CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Pozwól na wszystkie źródła
    allow_credentials=True,
    allow_methods=["*"],  # Pozwól na wszystkie metody
    allow_headers=["*"],  # Pozwól na wszystkie nagłówki
)

class LoginRequest(BaseModel):
    email: str
    password: str

class RegisterRequest(BaseModel):
    name: str
    email: str
    password: str

class ValidateTokenRequest(BaseModel):
    token: str

@app.post("/auth/login")
async def login(request: LoginRequest):
    user_data = redis_client.get_user_by_email(request.email)
    
    if not user_data or not verify_password(request.password, user_data["password"]):
        raise HTTPException(
            status_code=401,
            detail="Nieprawidłowy email lub hasło"
        )

    token = create_access_token({"sub": user_data["id"]})
    redis_client.store_token(
        user_data["id"],
        token,
        settings.ACCESS_TOKEN_EXPIRE_MINUTES * 60
    )

    return {
        "token": token,
        "user": {
            "id": user_data["id"],
            "name": user_data["name"],
            "email": user_data["email"],
            "role": user_data["role"]
        }
    }

@app.post("/auth/register")
async def register(request: RegisterRequest):
    if redis_client.get_user_by_email(request.email):
        raise HTTPException(
            status_code=400,
            detail="Użytkownik z tym adresem email już istnieje"
        )

    user_data = {
        "id": str(uuid.uuid4()),
        "name": request.name,
        "email": request.email,
        "password": get_password_hash(request.password),
        "role": "user"
    }

    redis_client.create_user(user_data)

    return {
        "success": True,
        "message": "Użytkownik został zarejestrowany"
    }

@app.post("/auth/validate")
async def validate_token(request: ValidateTokenRequest):
    user_data = redis_client.validate_token(request.token)
    
    if not user_data:
        return {"valid": False}

    return {
        "valid": True,
        "user": {
            "id": user_data["id"],
            "name": user_data["name"],
            "email": user_data["email"],
            "role": user_data["role"]
        }
    } 