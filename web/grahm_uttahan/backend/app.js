const express = require("express");
const app = express();
const morgan = require("morgan");
const bodyParser = require("body-parser");
const mongoose = require("mongoose");
const methodOverride = require('method-override');   
const path = require('path');
const cors = require('cors');


const adminRoutes = require('./api/routes/admin');
const farmerRoutes = require('./api/routes/farmer');
const cropCategoryRoutes = require('./api/routes/cropCategory');
const childCropCategoryRoutes = require('./api/routes/childCropCategory');
const merchantRoutes = require('./api/routes/merchant');
const cropBidRoutes = require('./api/routes/cropBid');

mongoose.Promise = global.Promise;

mongoose.connect(
'mongodb://super:super123@ds155614.mlab.com:55614/superlatives',
  {
    useMongoClient: true
  }
).then(result => {
  console.log("connected");
})
.catch(err => {
  console.log(err);
});


app.use(morgan("dev"));
app.use(cors());  
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept, Authorization"
  );
  if (req.method === "OPTIONS") {
    res.header("Access-Control-Allow-Methods", "PUT, POST, PATCH, DELETE, GET");
    return res.status(200).json({});
  }
  next();
});

app.use(methodOverride());                                     


// Routes which should handle requests
app.use("/admin", adminRoutes);
app.use("/farmer", farmerRoutes);
app.use("/merchant", merchantRoutes);
app.use("/cropCategory", cropCategoryRoutes);
app.use("/childCropCategory", childCropCategoryRoutes);
app.use("/cropBid", cropBidRoutes);


app.use((req, res, next) => {
  const error = new Error("Not found");
  error.status = 404;
  next(error);
});

app.use((error, req, res, next) => {
  res.status(error.status || 500);
  res.json({
    error: {
      message: error.message
    }
  });
});

module.exports = app;
