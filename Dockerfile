# Stage 1: Build the application
FROM python:3.10-slim as builder

# Set working directory to /app
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Collect static files
RUN python manage.py collectstatic --no-input

# Stage 2: Run the application
FROM python:3.10-slim

# Set working directory to /app
WORKDIR /app

# Copy dependencies from previous stage
COPY --from=builder /app/requirements.txt .
COPY --from=builder /app/. .

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Expose port
EXPOSE 8000

# Run command to start the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# Security best practices
USER nobody:nobody
