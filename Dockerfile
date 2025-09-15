FROM python:3.12-slim as base

RUN apt update && apt install -y gcc default-libmysqlclient-dev build-essential pkg-config

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["python", "manage.py", "migrate", "--noinput"] && python manage.py runserver 0.0.0.0:8000 

# However the above command won't work in a Dockerfile so we'll use the following instead
CMD ["sh", "-c", "python manage.py migrate --noinput && python manage.py runserver 0.0.0.0:8000"]