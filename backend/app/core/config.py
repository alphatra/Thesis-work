from pydantic import BaseModel
from typing import Optional

class Settings(BaseModel):
    REDIS_HOST: str = "redis-10364.c245.us-east-1-3.ec2.redns.redis-cloud.com"
    REDIS_PORT: int = 10364
    REDIS_DB: int = 0
    REDIS_PASSWORD: Optional[str] = "FULKyHDjqPTygAhyQDJ3Pr4S72qaL3i6"
    SECRET_KEY: str = "Aqqka2uym7qwzhxr3weego56ffdq5v6x2fpkh56ndfah771s4m"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 7  # 7 days
    ALGORITHM: str = "HS256"

    class Config:
        env_file = ".env"

settings = Settings()
