**Django Production Dockerfile**
```dockerfile
# Stage 1: Build
FROM python:3.11-slim as build

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install production dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY . .

# Set environment variables for production
ENV DJANGO_SETTINGS_MODULE=config.settings.production
ENV PORT 8000

# Run migration commands for Django
RUN python manage.py migrate --no-input

# Stage 2: Final
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy compiled and installed dependencies from build stage
COPY --from=build /app/ .

# Expose correct port
EXPOSE 8000

# Run command to start Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
```

**Explanation**

This Dockerfile uses a multi-stage build process to separate the build and final stages. The build stage installs production dependencies, copies source code, sets environment variables, and runs migration commands. The final stage copies the compiled and installed dependencies from the build stage and sets up the environment to run the Django application.

**Best Practices**

*   We use a lightweight base image (`python:3.11-slim`) to reduce the image size.
*   We use `--no-cache-dir` with `pip install` to prevent caching of dependencies.
*   We use `COPY --from=build` to copy compiled and installed dependencies from the build stage, which helps to leverage Docker's caching mechanism.
*   We set environment variables for production, such as `DJANGO_SETTINGS_MODULE` and `PORT`.
*   We expose the correct port (`8000`) for the Django application.
*   We use `RUN python manage.py migrate --no-input` to run migration commands automatically.

**Example Use Case**

To build and run the Docker image, follow these steps:

1.  Create a `requirements.txt` file in your project directory with the required dependencies.
2.  Create a `config` directory with a `settings` directory inside, and a `production.py` file with your production settings.
3.  Run the following command to build the Docker image:
    ```bash
docker build -t my-django-app .
```
4.  Run the following command to start a container from the image:
    ```bash
docker run -p 8000:8000 my-django-app
```
5.  Access your Django application at `http://localhost:8000`.

Note: Make sure to replace `my-django-app` with your desired image name. Also, ensure that your `manage.py` file is in the root of your project directory.