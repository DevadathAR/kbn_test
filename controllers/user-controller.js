const pool = require('../db');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

module.exports.signupUser = async (req, res) => {
  const { role, name, username, password, contact } = req.body;

  try {
    // Check if the email already exists
    const queryCheckUser = 'SELECT * FROM users WHERE username = ?';
    const [rows] = await pool.query(queryCheckUser, [username]);

    if (rows.length > 0) {
      return res.status(403).json({ message: 'Email already taken' });
    }

    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Construct the image URL
    const imageLink = req.file ? `/uploads/${req.file.filename}` : null;

    // Insert new user
    const queryUserInsert = `
      INSERT INTO users (role, name, username, hpassword, image, resumeLink, contact) 
      VALUES (?, ?, ?, ?, ?, ?, ?)
    `;

    const placeholdersUser = [
      role,
      name,
      username,
      hashedPassword,
      imageLink,
      null,
      contact,
    ];

    const [responseUser] = await pool.query(queryUserInsert, placeholdersUser);

    // API Response
    res.status(201).json({
      message: 'User Created Successfully',
      user_id: responseUser.insertId,
    });
  } catch (err) {
    console.error('Error during signup', err);
    res.status(500).json({ message: 'Internal Server Error' });
  }
};

module.exports.loginUser = async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM users WHERE username = ?', [
      req.body.username,
    ]);
    console.log('Login Request', req.body);

    // if username doesnt exist
    if (rows.length === 0) {
      return res.status(401).json({ message: 'Invalid email' });
    }

    const user = rows[0];

    // password verification
    try {
      const isMatching = await bcrypt.compare(
        req.body.password,
        user.hpassword
      );

      if (!isMatching) {
        return res.status(401).json({ message: 'Invalid email or password' });
      }
    } catch (err) {
      console.error('Error comparing passwords:', err);
      return res.status(500).json({ message: 'Internal Server Error' });
    }

    // generating the verification token for user to login in
    try {
      const token = jwt.sign(
        { id: user.userID, type: user.role },
        process.env.TOKEN_KEY,
        { expiresIn: '365d' }
      );
      return res.status(200).json({ message: 'Login successful', token });
    } catch (err) {
      console.error('Error generating token:', err);
      return res.status(500).json({ message: 'Internal Server Error' });
    }
  } catch (err) {
    console.error('Error during login: ', err);
    res.status(500).json({ message: 'Internal Server Error' });
  }
};

module.exports.forgotPassword = async (req, res) => {};
