# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install dependencies
RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy project
COPY . .

# Collect static files
RUN python manage.py collectstatic --no-input

# Expose port 8000 to the docker host, so we can access it
# from the outside
EXPOSE 8000

# Run the command to start the development server
# when the container launches
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]