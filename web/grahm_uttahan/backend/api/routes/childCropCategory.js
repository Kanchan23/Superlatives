const express = require("express");
const router = express.Router();
const checkAuth = require('../middleware/check-auth');
const ChildCropCategoryController = require('../controllers/childCropCategory');


router.get("/", ChildCropCategoryController.category_get_all);

router.post("/", checkAuth, ChildCropCategoryController.category_create_category);

router.patch("/", checkAuth, ChildCropCategoryController.category_update_category);

router.delete("/:categoryId", checkAuth, ChildCropCategoryController.category_delete_category);


module.exports = router;