# Build Phase
FROM node:alpine as builder

WORKDIR '/app'

# Copy only the package.json file to install dependencies
COPY package.json .
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the production version
RUN npm run build

# Run Phase
FROM nginx

# Copy only the necessary files from the builder phase
COPY --from=builder /app/build /usr/share/nginx/html

# Nginx image automatically starts the server, so no need for a separate CMD

