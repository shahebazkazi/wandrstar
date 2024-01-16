# Use the official Node.js 18 image as a base
FROM node:18

# Set the working directory to /usr/src/app
WORKDIR /usr/src/app


# Copy package.json and package-lock.json to the container

COPY package*.json ./


# Install dependencies

RUN npm install


# Copy the rest of the application code
COPY . .

# Expose the port the app runs on (replace with your app's port)
EXPOSE 3000

# Define the command to start the application
CMD ["npm", "start"]
