# Use an official Node.js runtime as the base image
FROM node:18-alpine AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json before installing dependencies
COPY . .

# Install dependencies
RUN npm install

# Build the React app
RUN npm run build

# Use an official Nginx image to serve the built React app
FROM nginx:alpine

# Copy the build output to Nginx's default public directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for the application
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
