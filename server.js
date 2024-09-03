const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');

dotenv.config({ path: './.env' });

const app = express();

app.use(cors());
app.use(express.json());

app.use(express.static('public'));

const routes = require('./routes');
app.use(routes);

app.listen(process.env.PORT, '0.0.0.0', () => {
  console.log(`Server is running on http://192.168.29.37:${process.env.PORT}`);
});
