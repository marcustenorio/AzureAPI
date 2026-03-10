from fastapi import FastAPI

app = FastAPI(title="Azure Internal API")


@app.get("/health")
def health():
    return {"status": "ok"}


@app.get("/ready")
def ready():
    return {"ready": True}
