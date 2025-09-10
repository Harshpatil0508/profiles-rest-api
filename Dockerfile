# Stage 1: Build stage for Django application
FROM python:3.10-slim as build-stage

# Set working directory to /app
WORKDIR /app

# Copy requirements file to working directory
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code to working directory
COPY . .

# Collect static files
RUN python manage.py collectstatic --no-input

# Stage 2: Production stage for Django application
FROM python:3.10-slim

# Set working directory to /app
WORKDIR /app

# Copy dependencies from build stage
COPY --from=build-stage /app/requirements.txt .
COPY --from=build-stage /app/. .

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Expose port for Django development server
EXPOSE 8000

# Run command to start Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# Security best practices
# Run as non-root user
RUN groupadd -r django && useradd -r -g django django
USER django

# Use SQLite database
RUN apt update && apt install -y libsqlite3-dev
RUN python -m pip install pysqlite3

# Set working directory permissions
RUN chown -R django:django /app

# Health check for container
HEALTHCHECK --interval=10s --timeout=5s --retries=3 \
  CMD curl --fail http://localhost:8000/ || exit 1