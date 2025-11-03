FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt || true
COPY src/ ./
ENV WORKER_INTERVAL=5
CMD ["python", "worker.py"]
