FROM python:3.12-slim

WORKDIR /app

# Copy source and install
COPY . .
RUN pip install --no-cache-dir .

# /config — proxy config.yaml (mounted read-only from docker compose)
# /data   — SQLite reasoning_content cache (named volume, persisted)
VOLUME ["/data", "/config"]

EXPOSE 9000

ENTRYPOINT ["deepseek-cursor-proxy", \
  "--no-ngrok", \
  "--host", "0.0.0.0", \
  "--port", "9000", \
  "--config", "/config/config.yaml", \
  "--reasoning-content-path", "/data/reasoning_content.sqlite3"]
