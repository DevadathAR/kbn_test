const userRouter = require('./user-router');
const companyRouter = require('./company-router');

const express = require('express');
const router = express.Router();

router.use('/user', userRouter);
router.use('/company', companyRouter);

module.exports = router;
