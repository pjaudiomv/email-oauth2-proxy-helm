FROM python:3.12-slim

WORKDIR /app

RUN mkdir /app/cache && mkdir /app/config && apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential procps vim telnet netcat-openbsd net-tools ca-certificates curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -o requirements-core.txt https://raw.githubusercontent.com/simonrob/email-oauth2-proxy/refs/heads/main/requirements-core.txt \
    && curl -o emailproxy.py https://raw.githubusercontent.com/simonrob/email-oauth2-proxy/refs/heads/main/emailproxy.py \
    && pip install --no-cache-dir -r requirements-core.txt \
    && pip install --upgrade certifi

COPY emailproxy.config.tpl .
COPY docker-entrypoint.sh .

RUN chmod +x /app/docker-entrypoint.sh

ENTRYPOINT ["/app/docker-entrypoint.sh"]

CMD ["python", "emailproxy.py", "--no-gui"]
