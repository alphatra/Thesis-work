import grpc
from concurrent import futures
import time
import logging
from ..core.security import verify_password, create_access_token
from ..db.redis_client import redis_client
from ..core.config import settings

# Import generated gRPC code
import auth_pb2
import auth_pb2_grpc

class AuthServicer(auth_pb2_grpc.AuthServiceServicer):
    def Login(self, request, context):
        user_data = redis_client.get_user_by_email(request.email)
        
        if not user_data or not verify_password(request.password, user_data["password"]):
            context.set_code(grpc.StatusCode.UNAUTHENTICATED)
            context.set_details("Invalid email or password")
            return auth_pb2.LoginResponse()
            
        token = create_access_token({"sub": user_data["id"]})
        redis_client.store_token(
            user_data["id"], 
            token, 
            settings.ACCESS_TOKEN_EXPIRE_MINUTES * 60
        )
        
        user_message = auth_pb2.UserMessage(
            id=user_data["id"],
            name=user_data["name"],
            email=user_data["email"],
            role=user_data["role"]
        )
        
        return auth_pb2.LoginResponse(token=token, user=user_message)
    
    def Register(self, request, context):
        if redis_client.get_user_by_email(request.email):
            context.set_code(grpc.StatusCode.ALREADY_EXISTS)
            context.set_details("User with this email already exists")
            return auth_pb2.RegisterResponse(
                success=False,
                message="User with this email already exists"
            )
            
        user_data = {
            "id": str(uuid.uuid4()),
            "name": request.name,
            "email": request.email,
            "password": get_password_hash(request.password),
            "role": "user"
        }
        
        redis_client.create_user(user_data)
        
        return auth_pb2.RegisterResponse(
            success=True,
            message="User registered successfully"
        )
    
    def ValidateToken(self, request, context):
        user_data = redis_client.validate_token(request.token)
        
        if not user_data:
            return auth_pb2.ValidateTokenResponse(valid=False)
            
        user_message = auth_pb2.UserMessage(
            id=user_data["id"],
            name=user_data["name"],
            email=user_data["email"],
            role=user_data["role"]
        )
        
        return auth_pb2.ValidateTokenResponse(valid=True, user=user_message)

def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    auth_pb2_grpc.add_AuthServiceServicer_to_server(AuthServicer(), server)
    server.add_insecure_port('[::]:50051')
    server.start()
    logging.info("gRPC server started on port 50051")
    
    try:
        while True:
            time.sleep(86400)  # One day in seconds
    except KeyboardInterrupt:
        server.stop(0)