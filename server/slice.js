const execSync = require("child_process").execSync;

const { dirname } = require("path");
const appDir = dirname(require.main.filename);
const filePath = `${appDir}/uploads`;

const getSlicerInformation = ()=>{
  // const fs = require('fs');
  // const data = fs.readFileSync(`./sliceInformation.txt`, 'utf8');
  // return data;
  const slicerInformation  = require("./sliceInformation.json");
  return Object.keys(slicerInformation).map((slicer)=>{
    return `-s ${slicer}="${slicerInformation[slicer]}"`
  }).join().replaceAll(","," ");
}

const sliceModel = (
  input_file,
  printer_def = "./../printerDefinitions/ultimaker3.def.json"
  ) => {
  const outputPath = `${appDir}/outputs/${input_file.split(".")[0]}.gcode`;
  // console.log(getSlicerInformation());
  const output = execSync(
    `CuraEngine slice -v -p -j ${printer_def} -o ${outputPath} ${getSlicerInformation()} -l ${filePath}/${input_file}`,
    { encoding: "utf-8" }
  ); // the default is 'buffer'

  console.log("Output was:\n", output);
};

module.exports = { sliceModel };
