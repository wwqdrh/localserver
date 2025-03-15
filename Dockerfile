FROM hrdqww/edge-mini:0.1.8

COPY . /app/

WORKDIR /app

RUN chmod +x /app/run.sh

ENTRYPOINT ["sh", "-x", "/app/run.sh"]
