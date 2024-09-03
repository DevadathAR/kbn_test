const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: process.env.DB_PASSWORD,
  database: process.env.DATABASE,
});

const testConnection = async () => {
  try {
    const [rows] = await pool.query('SELECT 1 AS test');
    console.log('SQL Server Connected', rows);
  } catch (err) {
    console.error('Error connecting to the database:', err);
  }
};

testConnection();

module.exports = pool;
