const express = require("express");
const router = express.Router();
const multer = require('multer');

var aws = require('aws-sdk')
var multerS3 = require('multer-s3')

exports.multerFunction = (direct) => {

aws.config.update({
  signatureVersion: 'v4',
  secretAccessKey:'0byI1eutsncix+916SzzuS5ldpo58cCyjXGuupM9',
  accessKeyId: 'AKIAJHAZDB5WGKZXQASA',
  region: 'us-east-1'
})

var s3 = new aws.S3()
 
var upload = multer({
  storage: multerS3({
    s3: s3,
    acl: 'public-read',
    bucket: 'aimil',
    key: function (req, file, cb) {
      cb(null, Date.now()+file.originalname.replace(/\s+/g, '-'));
    }
  })
})

return upload

}
