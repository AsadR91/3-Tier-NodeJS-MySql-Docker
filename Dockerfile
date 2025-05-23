<<<<<<< HEAD
# Use an alpine Node.js runtime as a parent image
FROM node:14-alpine

# Set the working directory in the container for the client
WORKDIR /usr/src/app/client

# Copy the client package.json and package-lock.json
COPY client/package*.json ./

# Install the client dependencies
RUN npm install

# Copy the client source code
COPY client/ ./

# Build the client application
RUN npm run build

# Set the working directory in the container for the server
WORKDIR /usr/src/app/server

# Copy the server package.json and package-lock.json
COPY server/package*.json ./

# Install the server dependencies
RUN npm install

# Copy the server source code
COPY server/ ./

# Copy the client build files to the server's public directory
RUN mkdir -p ./public && cp -R /usr/src/app/client/dist/* ./public/

# Expose the port the server will run on
EXPOSE 5000

# Command to run the server
CMD ["npm", "start"]

=======
# Base image
FROM node:18

# ====== CLIENT BUILD ======
WORKDIR /usr/src/app/client

COPY client/package*.json ./
RUN npm install

COPY client/ ./
RUN npm run build

# ====== SERVER BUILD ======
WORKDIR /usr/src/app/server

COPY server/package*.json ./
#RUN npm install  
RUN npm install --legacy-peer-deps


COPY server/ ./

# Copy client build output to server's public directory
RUN mkdir -p ./public && cp -R /usr/src/app/client/dist/* ./public/

EXPOSE 5000

CMD ["npm", "start"]
>>>>>>> f2bfdc2 (Initial commit: fix package.json and setup project)
