const express = require("express");
const app = express();
const multer = require("multer");
const { sliceModel } = require("./slice");
const path = require("path");
require("dotenv").config();
const { dirname } = require("path");
const { randomUUID } = require("crypto");
const appDir = dirname(require.main.filename);
const fs = require("fs");

app.use(express.urlencoded({ extended: false, limit: "50mb" }));


const PORT = process.env.PORT || 3000;

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, `${appDir}/uploads`);
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + "-" + file.originalname.replaceAll(" ", "_"));
  },
});

const upload = multer({ storage: storage });

app.get("/", (req, res) => {
  res.send("hi");
});

app.post("/slice", upload.single("uploaded_file"),(req, res) => {
  if (!req.file) {
    return res.status(400).send('No files were uploaded.');
  }
  sliceModel(req.file.filename, req.body.printer);
  res.download(`${appDir}/outputs/${req.file.filename.split(".")[0]}.gcode`, (err) => {
    if (err) {
      console.log(err);
      res.status(500).send("error");
    }
    //deleting files from server
    fs.unlinkSync(`${appDir}/outputs/${req.file.filename.split(".")[0]}.gcode`);
    fs.unlinkSync(`${appDir}/uploads/${req.file.filename}`);
  });
  // res.status(200).send("done");

});


app.post("sliceCustom",(req,res) =>{


})

app.listen(PORT, () => {
  console.log(`server running on ${PORT}`);
});
