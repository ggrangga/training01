const axios = require('axios');
const enums = require('../enum');

module.exports = {
  lookupWord,
  getAngram01,
  getAngram02,
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

async function getAngram02(lookup1, mongoose){
  const Anagram = mongoose.model('anagrams');
  const arr = getCombinationOfWord(lookup1);
  const existingAnagram = await Anagram.findOne({'title':'words.txt', 'data': {$in:[...arr]}});
  return existingAnagram !== null ? {"status": "Data sukses matching"} : null;
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