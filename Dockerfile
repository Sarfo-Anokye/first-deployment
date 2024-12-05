# Stage 1: Dependencies Install Stage
FROM node:18-alpine AS dependencies

WORKDIR /app

# Create a volume
VOLUME /myvolume

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Stage 2: Production Stage
FROM node:18-alpine AS production

WORKDIR /app

# Create a volume
VOLUME /myvolume

# Copy only required files from the previous stage
COPY --from=dependencies /app/package*.json ./
COPY --from=dependencies /app/node_modules ./node_modules
COPY --from=dependencies /app .

# Expose the application port
EXPOSE 5000

# Start the application
CMD ["npm", "start"]
