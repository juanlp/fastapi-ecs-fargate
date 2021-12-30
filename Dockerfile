FROM python:3.9-slim

COPY requirements.txt /app/
WORKDIR /app

RUN python -m venv /app/venv \
    && . /app/venv/bin/activate \
    && pip install --no-cache-dir -U pip==21.1.3 \
    && pip install --no-cache-dir -r requirements.txt

COPY ./app/ /app/

EXPOSE 8000

CMD ["/app/venv/bin/uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
