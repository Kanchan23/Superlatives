const mongoose = require('mongoose');

const ChildCropCategorySchema = mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    name: { type: String, required: true },
    cropCategory: { type: mongoose.Schema.Types.ObjectId, ref: 'CropCategory', required: false },
    });

module.exports = mongoose.model('ChildCropCategory', ChildCropCategorySchema);