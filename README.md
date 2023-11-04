# CuraEngine-Docker
This is a fork of https://github.com/Printerverse/CuraEngine-Docker

Works with cura Version 5.5

I updated the docker file to work with newer versions of curaEngine and automaticly get the newest printer definition files.
I also extended the functionality of the node Server added a way to slice for a specific printer and added support for additional parameters 

## Instructions
- in the root of project directory run ```docker build -t cura-node .``` to build the docker image
- run docker container with the command below
```docker run -it -p 4000:8080 cura-node```
- send a stl file and the printerType as "printer" as multipart form-data to localhost:4000/slice to obtain the gcode and name the file parameter uploaded_file (all printers can be found [here](https://github.com/Ultimaker/Cura/tree/main/resources/definitions))
- additional parameters can be added in the parameters array. All parameters can be found [here.]( https://github.com/Ultimaker/Cura/tree/main/resources/definitions/fdmprinter.def.json)
- the model orientation must be set before the model is send
- You can also add a printer definition file as Json together with the stl model to /sliceCustom with  

## Bugfixing

When you get an slicing error simmilar to this:

```Trying to retrieve setting with no value given: roofing_layer_count```

To resolve the issue with the command problem when using Cura printer profiles with CuraEngine, you should add the setting to the sliceInformation.json file and assign it a default value. The error arises due to the manner in which Cura typically includes parameters in the command line call.

## Debuging 

To test this file localy you can run the setup.sh file in the terminal it will do everything you need to test the server localy
It is recommended to use linux or wsl to run this code
run: ```bash test.sh ``` (this will pull the newest printer definitions from github, install all dependensis for the node server and start the server)

When using wsl you have to configure a port forwarding from port 3000 on wsl to your windows system (tutorial: https://en.number13.de/wsl2-windows-subsystem-ports-forwarding/).

## TODO

- add support for other printers than the ultimaker 3
- allow for print options to be passed to the server
- check for security problems (file code injection maby possible)
- check if the dockerfile still works like intendet 
