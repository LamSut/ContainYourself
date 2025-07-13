# base image node for build stage
FROM node:23-alpine AS build

# OpenSSL legacy provider (from node:23 to above)
ENV NODE_OPTIONS=--openssl-legacy-provider

# working directory of container is /app
WORKDIR /app

# copy package.json (package-lock.json) to working directory
# install dependencies faster with Docker cache (if unchanged)
COPY package*.json ./

# install dependencies
RUN npm install

# copy source code into workdir "/app" of container
COPY . .

# build ReactJS app, the app will be stored in "build" directory
RUN npm run build

## RUN STAGE ##

# base image Nginx for run stage
FROM nginx:1.27.3-alpine

# copy built React app to Nginx html
COPY --from=build /app/build /usr/share/nginx/html

# expose port 80 for Nginx
EXPOSE 80

# run nginx with daemon off (ensure the container remains active if Nginx is running)
ENTRYPOINT ["nginx", "-g", "daemon off;"]