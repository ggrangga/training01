const Joi = require('@hapi/joi');
const pangramService = require('../services/PangramService');

const schema = Joi.object({
  username: Joi.string()
      .alphanum()
      .min(5)
      .max(9)
      .required()
      .description('the User name used'),
});

const schema1 = Joi.object({
  anagram: Joi.string()
      .alphanum()
      .min(3)
      .required(),
  anagram1: Joi.string()
      .alphanum()
      .min(3)
      .required(),
});
module.exports = mongoose => [
  {
    method: 'GET',
    path: '/pangram',
    handler: async (request, response) => {
      request.lo
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
  {
    method: 'POST',
    path: '/anagram',
    handler: async (request, h) => {
      const anagram = request.payload.anagram;
      const anagram1 = request.payload.anagram1;
      const axios = require('axios');          
      const promise = new Promise((resolve, reject) => {
        if(anagram.length === anagram1.length)        
          Promise.all([
            pangramService.lookupWord(anagram),
            pangramService.lookupWord(anagram1),
          ]).then(async ([res1, res2]) =>{
            if(res1.data.found > 0 && res2.data.found > 0){
              /*this on working
              const resp = await pangramService.getAngram01(anagram);
              let tryFind = resp.data.all.find(x => x === anagram1);
              if(tryFind)
                resolve(h.response({"status": "Data sukses matching","other": resp.data.all.filter(x => x !== anagram && x !== anagram1)}).header('Content-Type', 'application/json'));
              */
              const resp = await pangramService.getAngram02(anagram, mongoose);
              if(resp)
                resolve(h.response({...resp}).header('Content-Type', 'application/json'));
            }
            resolve(h.response({"status": "Data not sukses matching"}).header('Content-Type', 'application/json'));
          });        
      });
      return promise;
    },
    options: {
      validate: {
        payload: schema1
      },
    }
  },
  {
    method: 'POST',
    path: '/addText',
    handler: async (request, response) => {
      const Anagram = mongoose.model('anagrams');
      var lineReader = require('line-reader');

      const title = JSON.parse(request.payload).title;
      
      function getFile() {
        return new Promise(function(resolve, reject) {
          let txts = [];
          console.log(title);
          lineReader.eachLine(title, function(line, last) {
            txts.push(line);
            if(last){
              resolve(txts);
            }
          });     
        })        
      };
      await getFile().then(async data => {
        const existingAnagram = await Anagram.findOne({'title': title});
        if(existingAnagram === null){
          await new Anagram({'data':data,'title': title}).save();
        }
      });

      return {'status':'Sukses','title': title};
    },
  },
  {
    method: 'GET',
    path: '/test',
    handler: async (request, response) => {
      const Anagram = mongoose.model('anagrams');
      const arr = pangramService.getCombinationOfWord('listen');
      const existingAnagram = await Anagram.findOne({'title':'words.txt', 'data': {$in:[...arr]}});
      return {'data':existingAnagram !== null ? true : false,statusCode: 500};
    },
    options: {
      tags: ['api'],
    }
  }
];