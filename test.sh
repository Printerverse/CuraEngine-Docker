if ! command -v CuraEngine &> /dev/null
then
    # ask the user if cura engine is installed
    echo "Cura Engine isnt installed or not in this path. Would you like to install it? (y/n)"
    read install
    if [ $install == "y" ]
    then
        echo "Installing Cura Engine..."
        sudo apt-get update
        sudo apt-get install -y cura-engine
    else
        echo "Please make shure Cura Engine is accessible in this path"
    fi

fi

if [ -d "printerDefinitions" ] 
then
    echo "printerDefinitions directory already exists"
else
    echo "installing printer definitions..." && \	
    git clone https://github.com/Ultimaker/Cura.git && \
    cp -r Cura/resources/definitions ./printerDefinitions && \
    rm -rf Cura
fi

cd server && \

echo "creating uploads directory..." && \

if [ -d "uploads" ] 
then
    echo "uploads directory already exists"
else
    echo "creating uploads and outputs directory"
    mkdir uploads
    mkdir outputs
fi

echo "installing dependencies..." && \
npm i 