# base image nginx for run stage
FROM nginx:1.27.3-alpine

# copy static web to nginx html
COPY . /usr/share/nginx/html

# expose port 80 for nginx
EXPOSE 80

# run nginx with daemon off (ensure the container remains active if nginx is running)
ENTRYPOINT ["nginx", "-g", "daemon off;"]