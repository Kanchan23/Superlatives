const mongoose = require("mongoose");
const CropBid = require("../models/cropBid");

//bid functions
exports.crop_bid_get_all = (req, res, next) => {
   CropBid.find({ bidFlag: false, cancelFlag: false })
    .populate("farmer_id", "first_name last_name")
    .populate("crop_category", "name")
    .exec()
    .then(docs => {
      res.status(200).json(docs)
    })
    .catch(err => {
      res.status(500).json({
        error: err
      });
    });
};

exports.crop_get_crop = (req, res, next) => {
  CropBid.find({ _id: req.params.cropBidId })
   .populate("farmer_id", "first_name last_name")
   .populate("crop_category", "name")
   .populate("merhcnat_id", "first_name last_name")
   .exec()
   .then(docs => {
     res.status(200).json(docs)
   })
   .catch(err => {
     res.status(500).json({
       error: err
     });
   });
};

exports.crop_accepted_get_all = (req, res, next) => {
  CropBid.find({ bidFlag: true, checkFlag: true, cancelFlag: false, merchant_id:req.userData.merchant._id})
   .populate("farmer_id", "first_name last_name")
   .populate("crop_category", "name")
   .populate("merchant_id", "first_name last_name")
   .exec()
   .then(docs => {
     res.status(200).json(docs)
   })
   .catch(err => {
     res.status(500).json({
       error: err
     });
   });
};

exports.crop_bid_farmer_get_all = (req, res, next) => {
  CropBid.find({ farmer_id: req.userData.farmer._id})
   .populate("merchant_id", "first_name last_name")
   .exec()
   .then(docs => {
     res.status(200).json(docs)
   })
   .catch(err => {
     res.status(500).json({
       error: err
     });
   });
};

exports.crop_bid_create = async (req, res, next) => {
  let body = req.body;
  body.farmer_id = req.userData.farmer._id;    
  body._id = new mongoose.Types.ObjectId();
  body.total = (body.quantity*body.price);
  body.created_at = new Date();
  body.status = "In Process";
  const crop_bid = new CropBid(body);
    crop_bid
    .save()
    .then(result => {
        res.status(201).json({
            message: "Crop Bid has been created",
            result
            
        });
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({
            error: err
        });
    });
};

// exports.crop_bid_create1 = async (req, res, next) => {
//   let body = req.body;
//   body.farmer_id = req.userData.farmer._id;   
//   body.price = parseFloat(req.body.price);
//   body.quantity = parseFloat(req.body.quantity); 
//   body._id = new mongoose.Types.ObjectId();
//   body.total = (body.quantity*body.price);
//   body.created_at = new Date();
//   body.status = "In Process";
//   const crop_bid = new CropBid(body);
//     crop_bid
//     .save()
//     .then(result => {
//         res.status(201).json({
//             price: body.price,
//             qunatity: body.quantity,
//             message: "Crop Bid has been created",
//             created:{
//             result
//             }
//         });
//     })
//     .catch(err => {
//         console.log(err);
//         res.status(500).json({
//             error: err
//         });
//     });
// };


exports.crop_bid_update = (req, res, next) => {
  const id = req.params.cropBidId;
  var query = { _id: id };
  var temp = "Accepted"
  var update = { bidFlag: true, checkFlag: true, merchant_id: req.userData.merchant._id, status: temp};
  CropBid.findOneAndUpdate(query, update)
  .exec()
  .then(result => {
    res.status(200).json({
      message: "Bid accepted",
      _id: result._id
    });
  })
  .catch(err => {
      res.status(500).json({
        error: err
      })
    });

};

exports.crop_bid_cancel_update= (req, res, next) => {
  const id = req.params.cropBidId;
  var temp = "cancelled";
  var query = { _id: id };
  var update = { checkFlag: true, cancelFlag: true, farmer_id: req.userData.farmer._id, status: temp};
  CropBid.findOneAndUpdate(query, update)
  .exec()
  .then(result => {
    res.status(200).json({
      message: "Bid accepted",
      _id: result._id
    });
  })
  .catch(err => {
      res.status(500).json({
        error: err
      })
    });

};