# Use Node.js 20
FROM node:20-alpine AS build-stage

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies WITHOUT running scripts
RUN npm install --ignore-scripts

# Copy all project files (including quasar.config.js)
COPY . .

# Now run quasar prepare manually if needed
RUN npx quasar prepare || true

# Build the app for production
RUN npx quasar build

# Production stage with Nginx
FROM nginx:stable-alpine AS production-stage

# Copy built files
COPY --from=build-stage /app/dist/spa /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]