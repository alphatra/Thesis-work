import redis
import json
from ..core.config import settings

class RedisClient:
    def __init__(self):
        self.redis = redis.Redis(
            host=settings.REDIS_HOST,
            port=settings.REDIS_PORT,
            db=settings.REDIS_DB,
            password=settings.REDIS_PASSWORD,
            decode_responses=True,
            ssl_cert_reqs = None,
        )

    def get_user_by_email(self, email: str):
        user_key = f"user:{email}"
        user_data = self.redis.get(user_key)
        if not user_data:
            return None
        return json.loads(user_data)

    def get_user_by_id(self, user_id: str):
        email = self.redis.get(f"userid:{user_id}")
        if not email:
            return None
        return self.get_user_by_email(email)

    def create_user(self, user_data: dict):
        email = user_data["email"]
        user_id = user_data["id"]
        user_key = f"user:{email}"

        # Store user email to ID mapping
        self.redis.set(f"userid:{user_id}", email)

        # Store user data
        self.redis.set(user_key, json.dumps(user_data))

    def store_token(self, user_id: str, token: str, expire_time: int):
        token_key = f"token:{token}"
        self.redis.set(token_key, user_id)
        self.redis.expire(token_key, expire_time)

    def validate_token(self, token: str):
        token_key = f"token:{token}"
        user_id = self.redis.get(token_key)
        if not user_id:
            return None
        return self.get_user_by_id(user_id)

redis_client = RedisClient()
