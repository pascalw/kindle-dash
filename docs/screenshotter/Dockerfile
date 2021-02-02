FROM node:12-buster-slim

RUN apt-get update \
    && apt-get install -y wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable fonts-freefont-ttf libxss1 fonts-noto-color-emoji \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD 1
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/google-chrome-stable

ADD package.json yarn.lock /app/

RUN cd /app && yarn install \
    # Add user so we don't need --no-sandbox.
    # same layer as npm install to keep re-chowned files from using up several hundred MBs more space
    && groupadd -r pptruser && useradd -r -g pptruser -G audio,video pptruser \
    && mkdir -p /home/pptruser/Downloads \
    && chown -R pptruser:pptruser /home/pptruser \
    && chown -R pptruser:pptruser /app/node_modules

ADD . /app/

# Run everything after as non-privileged user.
USER pptruser

CMD ["node", "/app/screenshot.js"]
