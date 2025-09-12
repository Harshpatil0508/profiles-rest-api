FROM python:3.12-slim as base

RUN apt update && apt install -y gcc default-libmysqlclient-dev build-essential pkg-config

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "manage.py", "migrate", "--no-input"] && python manage.py runserver 0.0.0.0:8000

EXPOSE 8000

ENTRYPOINT ["/bin/sh", "-c"]