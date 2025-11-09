FROM python:3.12-slim

WORKDIR /app

# Copy dependency files
COPY pyproject.toml ./

# Install dependencies
RUN pip install --no-cache-dir -e .

# Copy application code
COPY worker/ ./worker/

# Run Celery worker
CMD ["celery", "-A", "worker.celery_app.celery", "worker", "-Q", "default", "--loglevel=INFO"]
