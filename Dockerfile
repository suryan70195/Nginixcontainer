# Stage 1: Build the application (Node.js example)
FROM node:16 AS build-stage
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json /app/

# Install dependencies
RUN npm install --production

# Copy the rest of the source code
COPY ./src /app

# Run build if needed (uncomment if your app requires building)
# RUN npm run build

# Stage 2: Set up the Nginx server to serve the built app
FROM nginx:1.23.0 AS production-stage

# Remove the default Nginx welcome page
RUN rm -rf /usr/share/nginx/html/*

# Copy the built app (the 'public' directory) into Nginx's serving folder
COPY --from=build-stage /app/public /usr/share/nginx/html

# Optionally, copy a custom Nginx configuration file
COPY ./nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for Nginx
EXPOSE 80

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
