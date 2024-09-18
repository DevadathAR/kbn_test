const userRouter = require('./user-router');
const jobRouter = require('./job-router.js');
const adminRouter = require('./adminRouter.js');
const applicationRouter = require('./application-router.js');

const express = require('express');
const router = express.Router();

router.use('/user', userRouter);
router.use('/job', jobRouter);
router.use('/application', applicationRouter);
router.use('/admin', adminRouter);

module.exports = router;
