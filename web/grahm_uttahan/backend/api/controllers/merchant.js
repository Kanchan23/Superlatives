const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const crypto = require('crypto');
const Merchant = require("../models/merchant");
const axios = require("axios");
const nodemailer = require('nodemailer');
const async = require('async');

 exports.get_merchant_all = (req, res, next) => {
  Merchant.find().sort({first_name:1})
    .exec()
    .then(users => {
      res.status(200).json(users)
    })
    .catch(err=>{
      res.status(500).json({error:err});
    });
}

exports.merchant_signup = (req, res, next) => {
  Merchant.find({contact_no: req.body.contact_no})
    .exec()
    .then(merchant => {
      if (merchant.length >= 1) {
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
            body._id =  new mongoose.Types.ObjectId();
            body.password = hash;
            const merchant = new Merchant(body);
            merchant
              .save()
              .then(result => {
                res.status(201).json({
                  message: "Merchant account is created"
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

exports.merchant_login = (req, res, next) => {

  Merchant.findOne({ contact_no: req.body.contact_no })
    .exec()
    .then(merchant => {
      if (!merchant) {
        return res.status(401).json({
          message: "No merchant is registered with this number"
        });
      }
      bcrypt.compare(req.body.password, merchant.password, (err, result) => {
        if (err) {
          return res.status(401).json({
            message: "Auth failed"
          });
        }
        if (result) {
          const token = jwt.sign(
            {
              merchant
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

exports.merchant_delete = (req, res, next) => {
  Merchant.remove({ _id: req.params.merchantId })
    .exec()
    .then(result => {
      res.status(200).json({
        message: "Merchant deleted"
      });
    })
    .catch(err => {
      console.log(err);
      res.status(500).json({
        error: err
      });
    });
};



exports.get_merchant = (req, res, next) => {
  Merchant.find({_id:req.userData.merchant._id})
    .exec()
    .then(merchant => {
      res.status(200).json(merchant)
    });

}

  exports.update_merchant = (req, res, next) => {
    Merchant.findByIdAndUpdate({ _id: req.userData.merchant._id }, { $set:  req.body })
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