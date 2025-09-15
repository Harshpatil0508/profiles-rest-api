# Stage 1: Build
FROM python:3.12-slim as build
WORKDIR /app
RUN apt update && apt install -y gcc default-libmysqlclient-dev build-essential pkg-config
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Runtime
FROM python:3.12-slim
WORKDIR /app
RUN apt update && apt install -y gcc default-libmysqlclient-dev build-essential pkg-config
COPY --from=build /app/ .
COPY . .
EXPOSE 8000
CMD ["python", "manage.py", "migrate", "--no-input"]
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]