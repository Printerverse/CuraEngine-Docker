# CuraEngine-Docker
This is a fork of https://github.com/Printerverse/CuraEngine-Docker

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
