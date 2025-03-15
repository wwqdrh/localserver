FROM hrdqww/edge-mini:0.1.9

COPY . /app/

WORKDIR /app

RUN chmod +x /app/run.sh

ENTRYPOINT ["sh", "-x", "/app/run.sh"]
