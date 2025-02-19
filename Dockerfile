# Stage 1: Build the application (Node.js example)
FROM node:16 AS build-stage
WORKDIR /app

# Copy the source code into the container
COPY ./src /app

# Install dependencies and build the application
RUN npm install

# Stage 2: Set up the Nginx server to serve the built app
FROM nginx:alpine AS production-stage

# Remove the default Nginx welcome page
RUN rm -rf /usr/share/nginx/html/*

# Copy the built app (the 'public' directory) into Nginx's serving folder
COPY --from=build-stage /app/public /usr/share/nginx/html

# Optionally, copy a custom Nginx configuration file (if needed)
COPY ./nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for Nginx
EXPOSE 80

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
