'use strict';

const Hapi = require('@hapi/hapi');
const Inert = require('@hapi/inert');
const Vision = require('@hapi/vision');
const HapiSwagger = require('hapi-swagger');
const Pack = require('./package');

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

  const swaggerOptions = {
    info: {
        title: 'Test API Documentation',
        version: Pack.version,
      },
    };

  await server.register([
    Inert,
    Vision,
    {
      plugin: HapiSwagger,
      options: swaggerOptions
    }
  ]);

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