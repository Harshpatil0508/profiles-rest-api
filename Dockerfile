FROM python:3.12-slim as base

# Set working directory to /app
WORKDIR /app

# Install system packages needed for mysqlclient
RUN apt update && apt install -y gcc default-libmysqlclient-dev build-essential pkg-config

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy all project files
COPY . .

# Expose port 8000
EXPOSE 8000

# Run Django migrations and start the development server
CMD ["python", "manage.py", "migrate", "--no-input"] && \
    ["python", "manage.py", "runserver", "0.0.0.0:8000"]


# Optimized Dockerfile with multi-stage build
FROM python:3.12-slim

WORKDIR /app

COPY --from=base /app/ /app/

EXPOSE 8000

CMD ["python", "manage.py", "migrate", "--no-input"] && \
    ["python", "manage.py", "runserver", "0.0.0.0:8000"]