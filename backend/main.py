from fastapi import FastAPI
import uvicorn

app = FastAPI(
    title="Authentication Backend",
    description="Backend for the Flutter application",
    version="0.1.0",
)

@app.get("/")
def read_root():
    return {"status": "ok", "message": "Authentication service is running"}

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)