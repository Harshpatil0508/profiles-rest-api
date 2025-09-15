FROM python:3.12-slim as base

RUN apt update && apt install -y gcc default-libmysqlclient-dev build-essential pkg-config

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["python", "manage.py", "migrate", "--noinput"] && python manage.py runserver 0.0.0.0:8000 

# No, the above command won't work as expected in a Dockerfile, we should use an entrypoint script instead

# Let's correct the above Dockerfile to use an entrypoint script

FROM python:3.12-slim as base

RUN apt update && apt install -y gcc default-libmysqlclient-dev build-essential pkg-config

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

# entrypoint.sh should contain
# #!/bin/sh
# python manage.py migrate --noinput
# python manage.py runserver 0.0.0.0:8000 

# However since you asked for only Dockerfile content, here is the corrected version
FROM python:3.12-slim as base

RUN apt update && apt install -y gcc default-libmysqlclient-dev build-essential pkg-config

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]