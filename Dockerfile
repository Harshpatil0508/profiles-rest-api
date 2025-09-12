FROM python:3.12-slim as base

RUN apt update && apt install -y gcc default-libmysqlclient-dev build-essential pkg-config

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["python", "manage.py", "migrate", "--no-input"] && \
    ["python", "manage.py", "runserver", "0.0.0.0:8000"]


# Optimized version with two stages for better caching
FROM python:3.12-slim AS builder

RUN apt update && apt install -y gcc default-libmysqlclient-dev build-essential pkg-config

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN python manage.py migrate --no-input

FROM python:3.12-slim

WORKDIR /app

COPY --from=builder /app .

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]