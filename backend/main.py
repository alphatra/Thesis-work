from fastapi import FastAPI
import threading
import uvicorn
from app.api.grpc_server import serve

app = FastAPI(
    title="Authentication Backend",
    description="Backend for the Flutter application",
    version="0.1.0",
)

@app.get("/")
def read_root():
    return {"status": "ok", "message": "Authentication service is running"}

@app.on_event("startup")
def startup_event():
    # Start gRPC server in a separate thread
    grpc_thread = threading.Thread(target=serve, daemon=True)
    grpc_thread.start()

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)