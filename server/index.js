'use strict';

const Hapi = require('@hapi/hapi');

const mongoose = require('mongoose');
mongoose.connect('mongodb://noOne:noOne654321@ds217438.mlab.com:17438/training', {useUnifiedTopology: true, useNewUrlParser: true}).then(() => {
    console.log("Database Training is Connected");
}).catch((err) => {
    console.log("Database Training is Not Connected", err);
});

require('./models/Train');

const init = async () => {

  const server = Hapi.server({
    port: process.env.PORT || 3000,
    host: process.env.YOUR_HOST || '0.0.0.0'
  });

  server.route([
    ...require('./routes/pangram')(mongoose)
  ]);
  await server.start();
  console.log('Server running on %s', server.info.uri);
};

process.on('unhandledRejection', (err) => {

  console.log(err);
  process.exit(1);
});

init();