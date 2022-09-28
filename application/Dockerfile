FROM node:17-alpine3.15

# Set work app directory
WORKDIR /usr/src/app

COPY package*.json /usr/src/app/
RUN ["npm", "install"]
COPY . /usr/src/app/

RUN ["npm", "install", "prom-client"]

# Build app
RUN ["npm", "run", "build"]

# Expose app port
EXPOSE 3000

# Set owner user 'node'
RUN chown -R node:node /usr/src/app
USER node

# App container ENTRYPOINT
CMD ["node", "."]