const mongoose = require('mongoose');
const { Schema } = mongoose;

const trainSchema = new Schema({
  book: String,
  length: String,
  text: [],
  found: [],
});

mongoose.model('trains', trainSchema);