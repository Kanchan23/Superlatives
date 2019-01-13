const mongoose = require("mongoose");
const Admin = require("../models/admin");
const async = require('async');
const bcrypt = require("bcryptjs");
const nodemailer = require('nodemailer');
const jwt = require("jsonwebtoken");
const crypto = require('crypto');



 exports.admin_login = (req, res, next) => {
  Admin.findOne({ email: req.body.email })
    .exec()
    .then(admin => {
      if (!admin) {
        return res.status(401).json({
          message: "No Such Admin Exists"
        });
      }
      bcrypt.compare(req.body.password, admin.password, (err, result) => {
        if (err) {
          return res.status(401).json({
            message: "Auth failed"
          });
        }
        if (result) {
          const token = jwt.sign(
            {
              admin:admin,
              role:"admin"
            },
            "gramuthanam",{
              expiresIn: 606900 // expires in 7 days
          });
          return res.status(200).json({
            message: "Auth successful",
            token: token
          });
        }
        res.status(401).json({
          message: "Your password is wrong"
        });
      });
    })
    .catch(err => {
      res.status(500).json({
        error: err
      });
    });
};

