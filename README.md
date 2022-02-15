# CuraEngine-Docker
Docker based deployment of CuraEngine with node.js API

## Instructions
- in the root of project directory run
```docker build -t cura-node .```
- to build the docker image
- run docker container with the command below
```docker run -it -p 4000:8080 cura-node```
- now inside the container terminal run the node server
```node server/server.js```
- send a stl file with multipart form-data to localhost:4000/slice to obtain the gcode
