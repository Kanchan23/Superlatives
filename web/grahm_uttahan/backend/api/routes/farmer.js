const express = require("express");
const router = express.Router();
const FarmerController = require('../controllers/farmer');

const checkAuth = require('../middleware/check-auth');
const uploadMW = require('../middleware/multer-file');


router.get("/", checkAuth, FarmerController.get_farmer);

router.get("/all", checkAuth, FarmerController.get_farmer_all);

router.post("/signup", uploadMW.multerFunction().any(), FarmerController.farmer_signup);

router.post("/login", FarmerController.farmer_login);

router.patch("/", checkAuth,uploadMW.multerFunction().any(), FarmerController.update_farmer);

router.delete("/:farmerId", checkAuth, FarmerController.farmer_delete);

module.exports = router;
