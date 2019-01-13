const mongoose = require("mongoose");        
const ChildCropCategory = require("../models/childCropCategory");

exports.category_get_all = (req, res, next) => {
  ChildCropCategory.find().sort({name:1})
    .exec()
    .then(docs => {
      res.status(200).json({
        count: docs.length,
        category: docs.map(doc => {
          return {
            _id: doc._id,
            name: doc.name
          };
        })
      });
    })
    .catch(err => {
      res.status(500).json({
        error: err
      });
    });
};

exports.category_create_category = (req, res, next) => {
   const role = req.userData.role;
   if(role=="admin"){
        let body = req.body;
        body._id = new mongoose.Types.ObjectId();
        const category = new ChildCropCategory(body);
        category.save()
        .then(result => {
            res.status(201).json({
                message: "Crop Category stored",
                createdcategory: {
                _id: result._id,
                category: result.name
                }
            });
        })
        .catch(err => {
            res.status(500).json({
                error: err
            });
        });
    }else{
        res.status(401).json('Not Authorised');
    }    
};

exports.category_update_category = (req, res, next) => {
  ChildCropCategory.findByIdAndUpdate({ _id: req.body._id }, { name:  req.body.name })
     .exec()
     .then(result => {
       res.status(200).json({
         message: "Crop Category updated",
         request: {
           _id: result._id,  
         }
       });
     })
 .catch(err => {
   res.status(500).json({
     error: err
   });
 });
};

exports.category_delete_category = (req, res, next) => {
    ChildCropCategory.remove({ _id: req.params.categoryId })
    .exec()
    .then(result => {
      res.status(200).json({
        message: "Crop Category deleted"
      });
    })
    .catch(err => {
      res.status(500).json({
        error: err
      });
    });
};