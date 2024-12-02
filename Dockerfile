FROM node:18-alpine

RUN mkdir -p /home/docker-user

WORKDIR /home/docker-user

RUN adduser docker-user --disabled-password

COPY --chown=docker-user --chmod=500 ./scripts ./app/scripts
COPY --chown=docker-user --chmod=500 ./src ./app/src
COPY --chown=docker-user --chmod=500 ./node_modules ./app/node_modules
COPY --chown=docker-user --chmod=700 ./dist ./app/dist
COPY --chown=docker-user --chmod=400 package*.json ./app

USER docker-user

EXPOSE 3000 3000
EXPOSE 3001 3001

WORKDIR app

CMD ["node", "scripts/start.js"]
