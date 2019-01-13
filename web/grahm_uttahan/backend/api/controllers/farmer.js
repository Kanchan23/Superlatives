const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const crypto = require('crypto');
const Farmer = require("../models/farmer");
const axios = require("axios");
const nodemailer = require('nodemailer');
const async = require('async');

 exports.get_farmer_all = (req, res, next) => {
  Farmer.find().sort({first_name:1})
    .exec()
    .then(users => {
      res.status(200).json(users)
    })
    .catch(err=>{
      res.status(500).json({error:err});
    });
}

exports.farmer_signup = (req, res, next) => {
  Farmer.find({contact_no: req.body.contact_no})
    .exec()
    .then(farmer => {
      if (farmer.length >= 1) {
        return res.status(409).json({
          message: "Contact no exists"
        });
      } else {
        bcrypt.hash(req.body.password, 10, (err, hash) => {
          if (err) {
            return res.status(500).json({
              error: err
            });
          } else {
            let body = req.body;
            body.profile_image = req.files[0].location;
            body._id =  new mongoose.Types.ObjectId();
            body.password = hash;
            const farmer = new Farmer(body);
            farmer
              .save()
              .then(result => {
                console.log(result);
                res.status(201).json({
                  message: "Farmer account is created"
                });
              })
              .catch(err => {
                console.log(err);
                res.status(500).json({
                  error: err
                });
              });
          }
        });
      }
    });
};

exports.farmer_login = (req, res, next) => {

  Farmer.findOne({ contact_no: req.body.contact_no })
    .exec()
    .then(farmer => {
      if (!farmer) {
        return res.status(401).json({
          message: "No farmer is registered with this number"
        });
      }
      bcrypt.compare(req.body.password, farmer.password, (err, result) => {
        if (err) {
          return res.status(401).json({
            message: "Auth failed"
          });
        }
        if (result) {
          const token = jwt.sign(
            {
              farmer
            },
            "gramuthanam"
          );
          return res.status(200).json({
            message: "Auth successful",
            token: token
          });
        }
        res.status(401).json({
          message: "Wrong password"
        });
      });
    })
    .catch(err => {
      console.log(err);
      res.status(500).json({
        error: err
      });
    });
};

exports.farmer_delete = (req, res, next) => {
  Farmer.remove({ _id: req.params.farmerId })
    .exec()
    .then(result => {
      res.status(200).json({
        message: "Farmer deleted"
      });
    })
    .catch(err => {
      console.log(err);
      res.status(500).json({
        error: err
      });
    });
};



exports.get_farmer = (req, res, next) => {
  Farmer.find({_id:req.userData.farmer._id})
    .exec()
    .then(farmer => {
      res.status(200).json(farmer)
    });

}

  exports.update_farmer = (req, res, next) => {
    if(req.files.length !=0){
      req.body.profile_image = req.files[0].location;
    }
    Farmer.findByIdAndUpdate({ _id: req.userData.farmer._id }, { $set:  req.body })
    .exec()
    .then(result => {
      res.status(200).json({
        message: "Profile updated",
        _id: result._id
      });
    })
    .catch(err => {
      res.status(500).json({
        error: err
      });
    });
  }