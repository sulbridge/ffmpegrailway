FROM debian:bookworm-slim AS deps
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg curl && rm -rf /var/lib/apt/lists/*
FROM n8nio/n8n:latest
USER root
COPY --from=deps /usr/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=deps /usr/bin/ffprobe /usr/bin/ffprobe
COPY --from=deps /usr/bin/curl /usr/bin/curl
COPY --from=deps /usr/lib/ /usr/lib/
COPY --from=deps /lib/ /lib/
RUN chown -R node:node /home/node/.n8n
USER node

