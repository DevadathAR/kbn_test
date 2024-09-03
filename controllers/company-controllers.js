const pool = require('../db');

module.exports.signupCompany = async (req, res) => {
  res.status(200).json({ message: 'POST Signup' });
};

module.exports.loginCompany = async (req, res) => {
  const [rows] = await pool.query('SELECT * FROM employers WHERE email = ?', [
    req.body.email,
  ]);

  res.status(200).json({ message: 'POST Login' });
};
