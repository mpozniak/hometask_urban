FROM node:17-alpine3.15

# Set work app directory
WORKDIR /usr/src/app

COPY package*.json /usr/src/app/
RUN ["npm", "install"]
COPY . /usr/src/app/

# Build app
RUN ["npm", "run", "build"]

# Expose app port
EXPOSE 3000

# App container ENTRYPOINT
CMD ["node", "."]