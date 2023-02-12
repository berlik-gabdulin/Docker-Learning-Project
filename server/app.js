const express = require('express');
const mongoose = require('mongoose');
const path = require('path');
const routes = require('./routes/note.routes');
const cors = require('cors');

const app = express();
const port = process.env.PORT ?? 5000;

app.use(express.json({ extended: true }));
app.use(cors());
app.use('/api/note', routes);

async function start() {
  try {
    const {
      MONGO_INITDB_ROOT_USERNAME: username,
      MONGO_INITDB_ROOT_PASSWORD: password,
      MONGO_HOST: host,
    } = process.env;

    const uri = `mongodb://${username}:${password}@${host}/notes?authSource=admin`;

    await mongoose.connect(uri, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    app.listen(
      port,
      console.log.bind(console, `Server has been started on port ${port}`)
    );
  } catch (e) {
    console.log(e);
  }
}

start();
