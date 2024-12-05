# base image node for build stage
FROM node:23-alpine AS build

# working directory of container is /app
WORKDIR /app

# copy package.json (package-lock.json) to working directory
# install dependencies faster with Docker cache (if unchanged)
COPY package*.json ./

# install dependencies
RUN npm install

# copy source code into workdir "/app" of container
COPY . .

# build VueJS app, the app will be stored in "build" directory
RUN npm run build

## RUN STAGE ##

# base image Nginx for run stage
FROM nginx:1.27.3-alpine

# remove the existing /run directory if it exists
RUN rm -rf /run

# create new /run directory
RUN mkdir /run

# copy the built application from the build stage (VueJS stored in /app/dist)
COPY --from=build /app/dist /run

# copy the Nginx config file to the Nginx container config directory
COPY nginx.conf /etc/nginx/nginx.conf