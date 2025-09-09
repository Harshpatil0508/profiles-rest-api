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
```

Note: This Dockerfile assumes that you have a `requirements.txt` file in your project directory and that your Django project's `manage.py` file is in the root of your project directory. 

Also, note that using SQLite as a database in a container is not recommended for production environments as the data will be lost when the container is restarted or deleted. Consider using a more robust database solution like PostgreSQL or MySQL. 

To use this Dockerfile, create a `requirements.txt` file with `Django` and other required packages, then run `docker build -t my-django-app .` to build the image, and `docker run -p 8000:8000 my-django-app` to start the container.