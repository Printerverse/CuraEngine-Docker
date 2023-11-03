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
RUN apt-get -y install cura-engine

# Clone the cura repository and copy the definitions folder to the desired folder path 
RUN git clone https://github.com/Ultimaker/Cura.git && \
    cp -r Cura/resources/definitions ./printerDefinitions && \
    rm -rf Cura

# Expose port 8080
EXPOSE 8080
ENV PORT=8080

COPY server /server

# Install server dependencies
WORKDIR /server
RUN npm install

# Start your server when the container runs
CMD ["node", "app.js"]