const express = require("express");
const router = express.Router();
const checkAuth = require('../middleware/check-auth');
const CropCategoryController = require('../controllers/cropCategory');


router.get("/", CropCategoryController.category_get_all);

router.post("/", checkAuth, CropCategoryController.category_create_category);

router.patch("/", checkAuth, CropCategoryController.category_update_category);

router.delete("/:categoryId", checkAuth, CropCategoryController.category_delete_category);


module.exports = router;