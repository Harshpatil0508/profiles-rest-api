# Stage 1: Build
FROM python:3.12-slim as build
WORKDIR /app
RUN apt-get update && apt-get install -y gcc default-libmysqlclient-dev build-essential pkg-config
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Final image
FROM python:3.12-slim
WORKDIR /app
COPY --from=build /app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
RUN python manage.py migrate
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]