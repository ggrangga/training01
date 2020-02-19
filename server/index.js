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
    port: 3000,
    host: 'localhost'
  });

  server.route({
    method: 'GET',
    path: '/pangram',
    handler: async (request, response) => {
      const Train = mongoose.model('trains');
      const existingTrain = await Train.findOne({"book": '1661-0.txt_1'});
      if(existingTrain !== null){
        const randText = Math.floor(Math.random() * existingTrain.text.length);
        return {'data':{'text':existingTrain.text[randText]},statusCode: 200};
      }
      return {'data':{'test':'Hello World!'},statusCode: 500};
    }
  });
  await server.start();
  console.log('Server running on %s', server.info.uri);
};

process.on('unhandledRejection', (err) => {

  console.log(err);
  process.exit(1);
});

process.on('unhandledRejection', (err) => {

  console.log(err);
  process.exit(1);
});

init();