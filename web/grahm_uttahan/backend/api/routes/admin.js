const express = require("express");
const router = express.Router();
const uploadMW = require('../middleware/multer-file');
const AdminController = require('../controllers/admin');
const checkAuth = require('../middleware/check-auth');

router.post("/login", AdminController.admin_login);


module.exports = router;