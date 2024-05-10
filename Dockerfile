FROM zenika/alpine-chrome:with-node

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD 1
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium-browser
WORKDIR /usr/src/app
USER root
RUN apk add --no-cache ffmpeg
COPY --chown=chrome package.json ./
RUN npm install -g pnpm
RUN pnpm install
COPY --chown=chrome . ./
ENTRYPOINT ["tini", "--"]
CMD node server.mjs
