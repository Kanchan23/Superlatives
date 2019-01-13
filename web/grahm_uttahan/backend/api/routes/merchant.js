const express = require("express");
const router = express.Router();
const MerchantController = require('../controllers/merchant');
const checkAuth = require('../middleware/check-auth');
const uploadMW = require('../middleware/multer-file');

router.get("/", checkAuth, MerchantController.get_merchant);

router.get("/all", checkAuth, MerchantController.get_merchant_all);

router.post("/signup", uploadMW.multerFunction().any(), MerchantController.merchant_signup);

router.post("/login", MerchantController.merchant_login);

router.patch("/", checkAuth, MerchantController.update_merchant);

router.delete("/:merchantId", checkAuth, MerchantController.merchant_delete);

module.exports = router;
