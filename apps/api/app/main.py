"""Main FastAPI application for run-coach-rag API."""
from fastapi import FastAPI

app = FastAPI(title="run-coach-rag API")


@app.get("/healthz")
async def healthz() -> dict[str, str]:
    """Health check endpoint."""
    return {"status": "okkkk"}
