# ----------- Stage 1: Build ----------
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install all dependencies (including dev)
RUN npm install

# Copy all source files
COPY . .

# Build the app (if using a build step, e.g., for React/TypeScript)
# RUN npm run build  # Uncomment if your app has a build step

# ----------- Stage 2: Runtime ----------
FROM node:18-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy only necessary files from builder stage
COPY package*.json ./
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app ./

# Expose port
EXPOSE 3000

# Start app
CMD ["npm", "start"]