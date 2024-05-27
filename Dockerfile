FROM node:22-bookworm

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD 1
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium-browser
WORKDIR /usr/src/app

RUN apt-get update
RUN apt-get install -y chromium

# Installs emoji fonts
RUN apt-get install -y \
      fonts-freefont-ttf \
      fonts-noto-color-emoji \
      fonts-wqy-zenhei
COPY local.conf /etc/fonts/local.conf

COPY --chown=chrome package.json package*.json yarn.lock* pnpm-lock.yaml* bun.lockb* tsconfig.json* remotion.config.* ./

RUN npm install -g bun
RUN bun i

COPY --chown=chrome . ./

CMD bun server.mjs
