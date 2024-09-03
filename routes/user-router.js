const express = require('express');
const controller = require('../controllers/user-controller');
const upload = require('../middlewares/imageUpload');

const router = express.Router();

router.post('/signup', upload.single('image'), controller.signupUser);
router.post('/login', controller.loginUser);
// router.post('/forgot-password', controller.forgotPassword);
// router.post('/resume', controller.resumeById);

module.exports = router;
