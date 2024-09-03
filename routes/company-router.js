const express = require('express');
const controller = require('../controllers/company-controllers');
const upload = require('../middlewares/imageUpload');

const router = express.Router();

router.post('/sign-up', upload.single('image'), controller.signupCompany);
router.post('/login', controller.loginCompany);

module.exports = router;
