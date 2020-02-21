const mongoose = require('mongoose');
const { Schema } = mongoose;

const anagram = new Schema({
  data: [],
  title: String,
});

mongoose.model('anagrams', anagram);