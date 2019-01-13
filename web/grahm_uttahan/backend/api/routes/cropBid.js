const express = require("express");
const router = express.Router();
const checkAuth = require('../middleware/check-auth');
const CropBidController = require('../controllers/cropBid');
const uploadMW = require('../middleware/multer-file');
// Handle incoming GET requests to /cropBid

 router.get("/unaccepted", checkAuth, CropBidController.crop_bid_get_all);    // merchant

 router.get("/accepted", checkAuth, CropBidController.crop_accepted_get_all); //merchant

 router.get("/farmerBids", checkAuth, CropBidController.crop_bid_farmer_get_all); //farmer

 router.post("/", checkAuth, uploadMW.multerFunction().any(), CropBidController.crop_bid_create);

 //router.post("/new", checkAuth, uploadMW.multerFunction().any(), CropBidController.crop_bid_create1);

 router.get("/:cropBidId", checkAuth, CropBidController.crop_get_crop);    

router.patch("/:cropBidId", checkAuth, CropBidController.crop_bid_update);

router.patch("/cancel/:cropBidId", checkAuth, CropBidController.crop_bid_cancel_update); 

module.exports = router;
