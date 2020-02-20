const Joi = require('@hapi/joi');

const schema = Joi.object({
  username: Joi.string()
      .alphanum()
      .min(5)
      .max(9)
      .required()
      .description('the User name used'),
});
module.exports = mongoose => [
  {
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
    },
    options: {
      tags: ['api'],
    }
  },
  {
    method: 'POST',
    path: '/pangram',
    handler: async (request, h) => {
      const payload = request.payload;
      console.log(JSON.stringify(payload));
      return {'data':{'test':'Hello World!',"tr":payload.username},statusCode: 200};
    },
    options: {
      tags: ['api'],
      validate: {
        payload: schema
      },
    }
  },  
];