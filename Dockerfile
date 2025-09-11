**Django with SQLite Dockerfile**
=====================================

Here's a production-ready Dockerfile for a Django application using SQLite as the database:

```dockerfile
# Use an official Python image as the base
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Collect static files
RUN python manage.py collectstatic --no-input

# Expose the port the application will run on
EXPOSE 8000

# Run the command to start the development server when the container launches
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
```

**Explanation**
---------------

1.  **Base Image**: The Dockerfile starts with the `python:3.10-slim` image, which is a lightweight version of the official Python image.
2.  **Working Directory**: The `WORKDIR` instruction sets the working directory in the container to `/app`.
3.  **Install Dependencies**: The `pip install` command installs the dependencies listed in `requirements.txt`.
4.  **Copy Application Code**: The `COPY` instruction copies the application code into the container.
5.  **Collect Static Files**: The `collectstatic` command collects static files from the application and its dependencies.
6.  **Expose Port**: The `EXPOSE` instruction exposes port 8000, which is the default port for the Django development server.
7.  **Run Command**: The `CMD` instruction sets the default command to run when the container launches, which starts the Django development server.

**Example Use Case**
--------------------

To use this Dockerfile, follow these steps:

1.  Create a new directory for your project and navigate to it in your terminal.
2.  Create a new file called `Dockerfile` and paste the above code into it.
3.  Create a new file called `requirements.txt` and add the following line: `Django==4.1.7`
4.  Run the command `docker build -t my-django-app .` to build the Docker image.
5.  Run the command `docker run -p 8000:8000 my-django-app` to start the container and map port