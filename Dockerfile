# Stage 1: Build the application (Node.js example, can be any build process)
FROM node:16 AS build-stage
WORKDIR /app
COPY ./src /app  # Copy the source code into the container
RUN npm install && npm run build  # Build the application

# Stage 2: Set up the Nginx server to serve the built app
FROM nginx:alpine AS production-stage

# Remove the default Nginx welcome page
RUN rm -rf /usr/share/nginx/html/*

# Copy the built app from the build stage
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Optionally, copy a custom Nginx configuration file (if needed)
COPY ./nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for Nginx
EXPOSE 80

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]

