"""Celery application for run-coach-rag workers."""
import os
from celery import Celery

# Get Redis URL from environment with default
REDIS_URL = os.getenv("REDIS_URL", "redis://redis:6379/0")

# Initialize Celery app
celery = Celery(
    "run-coach-rag-workers",
    broker=REDIS_URL,
    backend=REDIS_URL,
)

# Configure Celery
celery.conf.update(
    task_serializer="json",
    accept_content=["json"],
    result_serializer="json",
    timezone="UTC",
    enable_utc=True,
)


@celery.task
def ping() -> str:
    """Demo ping task."""
    return "pong"
