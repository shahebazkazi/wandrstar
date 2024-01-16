# Use the official Node.js image as the base image
FROM --platform=linux/amd64 node:18
# FROM node:18

# Set the working directory inside the container
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Node.js dependencies
RUN npm install
# If you are building your code for production
# RUN npm ci --omit=dev

# Bundle app source
COPY . .

# Expose the port on which your Node.js application will run
EXPOSE 8080

# Command to run your Node.js application
CMD [ "node", "server.js" ]
