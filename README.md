# run-coach-rag

[![CI](https://github.com/chrisSvK/run-coach-rag/actions/workflows/ci.yml/badge.svg)](https://github.com/chrisSvK/run-coach-rag/actions/workflows/ci.yml)

AI-powered running coach with Retrieval-Augmented Generation (RAG) capabilities. This monorepo includes a FastAPI backend, Next.js frontend, and Celery workers for asynchronous task processing.

## 🏗️ Architecture

- **API** (FastAPI): RESTful API with health checks and endpoints for running analysis
- **Web** (Next.js 15 + TypeScript): Modern web interface with App Router
- **Workers** (Celery): Background task processing with Redis broker
- **Qdrant**: Vector database for RAG capabilities
- **Redis**: Message broker and result backend

## 🚀 Quick Start

### Prerequisites

- Docker and Docker Compose
- Node.js 20+ (for local development)
- Python 3.12+ (for local development)

### Run with Docker Compose

```bash
docker compose -f infra/docker/docker-compose.dev.yml up --build
```

This will start all services:

- **API**: http://localhost:8000
- **Web**: http://localhost:3000
- **Qdrant**: http://localhost:6333
- **Redis**: localhost:6379

### Service URLs

| Service          | URL                             | Description      |
| ---------------- | ------------------------------- | ---------------- |
| Web App          | http://localhost:3000           | Next.js frontend |
| API              | http://localhost:8000           | FastAPI backend  |
| API Docs         | http://localhost:8000/docs      | Swagger UI       |
| Qdrant           | http://localhost:6333           | Vector database  |
| Qdrant Dashboard | http://localhost:6333/dashboard | Qdrant UI        |

## ✅ Acceptance Checks

### 1. API Health Check

```bash
curl http://localhost:8000/healthz
# Expected output: {"status":"ok"}
```

### 2. Celery Worker Ping

```bash
docker compose -f infra/docker/docker-compose.dev.yml exec workers celery -A worker.celery_app.celery inspect ping
# Expected output: pong from worker
```

### 3. Next.js Web App

Visit http://localhost:3000 in your browser.

### 4. Qdrant Health Check

```bash
curl http://localhost:6333/
# Expected output: Qdrant API info
```

### 5. CI Pipeline

- GitHub Actions workflow runs on push and PR
- Generates CycloneDX SBOMs for Python and Node.js dependencies
- Artifacts: `bom-python-api.xml`, `bom-python-workers.xml`, `bom-node.xml`

## 📁 Repository Structure

```
run-coach-rag/
├── apps/
│   ├── api/                    # FastAPI service
│   │   ├── app/
│   │   │   ├── main.py        # Main API application
│   │   │   └── __init__.py
│   │   ├── pyproject.toml     # Python dependencies
│   │   └── Dockerfile
│   ├── web/                    # Next.js application
│   │   ├── app/               # App Router pages
│   │   ├── public/            # Static assets
│   │   ├── package.json
│   │   ├── next.config.ts
│   │   ├── tsconfig.json
│   │   └── Dockerfile
│   └── workers/                # Celery workers
│       ├── worker/
│       │   ├── celery_app.py  # Celery configuration
│       │   └── __init__.py
│       ├── pyproject.toml
│       └── Dockerfile
├── infra/
│   └── docker/
│       └── docker-compose.dev.yml  # Development compose file
├── .github/
│   └── workflows/
│       └── ci.yml              # CI pipeline with SBOM generation
├── .gitignore
├── LICENSE
└── README.md
```

## 🛠️ Local Development

### API (FastAPI)

```bash
cd apps/api
pip install -e .
uvicorn app.main:app --reload
```

### Web (Next.js)

```bash
cd apps/web
npm install
npm run dev
```

### Workers (Celery)

```bash
cd apps/workers
pip install -e .
celery -A worker.celery_app.celery worker -Q default --loglevel=INFO
```

## 🧪 Testing

### Test API Endpoint

```bash
curl http://localhost:8000/healthz
```

### Test Celery Task

```python
from worker.celery_app import ping
result = ping.delay()
print(result.get())  # Should print: "pong"
```

## 📦 SBOM Generation

The CI pipeline automatically generates Software Bill of Materials (SBOMs) using CycloneDX format:

- **Python SBOMs**: Generated for API and Workers using `cyclonedx-bom`
- **Node.js SBOM**: Generated for Web app using `@cyclonedx/cyclonedx-npm`

SBOMs are uploaded as GitHub Actions artifacts and can be used for:

- Dependency tracking
- Security vulnerability scanning
- License compliance
- Supply chain analysis

## 🔒 Environment Variables

### API

- `REDIS_URL`: Redis connection URL (default: `redis://redis:6379/0`)

### Web

- `NEXT_PUBLIC_API_URL`: API base URL (default: `http://localhost:8000`)

### Workers

- `REDIS_URL`: Redis connection URL (default: `redis://redis:6379/0`)

## 📋 Next Steps

### Week 2: Strava OAuth Integration

- [ ] Implement Strava OAuth flow
- [ ] Ingest running activities from Strava API
- [ ] Store activity data in database
- [ ] Create activity analysis endpoints

### Week 3: Screenshot OCR Pipeline

- [ ] Implement OCR for workout screenshots
- [ ] Extract structured data from images
- [ ] Store OCR results in Qdrant vector database
- [ ] Create search and retrieval endpoints

### Week 4: RAG Implementation

- [ ] Set up embedding models
- [ ] Implement semantic search over training data
- [ ] Create conversational AI coach interface
- [ ] Add personalized training recommendations

## 🤝 Contributing

1. Create a feature branch from `main`
2. Make your changes
3. Ensure all acceptance checks pass
4. Submit a pull request

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🔗 Links

- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Next.js Documentation](https://nextjs.org/docs)
- [Celery Documentation](https://docs.celeryq.dev/)
- [Qdrant Documentation](https://qdrant.tech/documentation/)
- [CycloneDX](https://cyclonedx.org/)
