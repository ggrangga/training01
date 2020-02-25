const axios = require('axios');
const enums = require('../enum');

module.exports = {
  lookupWord,
  getAngram01,
  getAngram02,
  getIsogram,
  getCombinationOfWord
};

async function lookupWord(lookup) {
  //return new Promise(axios.get(enums.url01+lookup));
  return await axios.get(enums.url01+lookup).then(resp => resp);
};

async function getAngram01(lookup1){
  return await axios.get(enums.url02+lookup1).then(resp => {
    return resp;
  });
};

async function getAngram02(lookup1, lookup2, mongoose){
  const Anagram = mongoose.model('anagrams');
  const arr = getCombinationOfWord(lookup1).filter(x => x === lookup2);
  if(arr){
    const existingAnagram = await Anagram.findOne({'title':'words.txt', 'data': {$in:[...arr]}});
    return existingAnagram !== null ? {"status": "Data sukses matching"} : null;
  }
  return null;  
};

function getIsogram(lookup1){
  let strArray = [];
  let resp = {};
  lookup1.split('').filter(x => x !== ' ' && x !== '-').forEach((element, index, array) => {
    let findX = strArray.find(x => x === element);
    if(findX) resp = {'status':'Not an Isogram!'};
    else strArray.push(element);
    
    if(index === array.length - 1 && Object.entries(resp).length === 0) 
      resp = {'status':'An Isogram!'};
  });
  return resp;
};

function getCombinationOfWord(chars){
  var tree = function(leafs) {
    var branches = [];
    if (leafs.length == 1) return leafs;
    for (var k in leafs) {
      var leaf = leafs[k];
      tree(leafs.join('').replace(leaf, '').split('')).concat("").map(function(subtree) {
        branches.push([leaf].concat(subtree));
      });
    }
    return branches;
  };
  return tree(chars.split('')).map(str => str.join('')).filter(x => x.length === chars.length);
};