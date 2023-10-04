# Use a base image with Ubuntu as the operating system
FROM node:latest

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install required dependencies
RUN apt-get update && \
    apt-get install -y \
    git \
    python3.10 \
    python3-pip \
    ninja-build \
    gcc-12 \
    cmake \
    make

    
#install curaEngine
Run apt-get -y install cura-engine

# CMD ["./build/CuraEngine"]

# Expose port 8080
EXPOSE 8080
ENV PORT=8080

COPY server /server

# Install server dependencies
WORKDIR /server
RUN npm install

# Start your server when the container runs
CMD ["node", "app.js"]