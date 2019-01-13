const mongoose = require('mongoose');

const CropBidSchema = mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    merchant_id: { type: mongoose.Schema.Types.ObjectId, ref: 'Merchant', required: false},
    farmer_id: { type: mongoose.Schema.Types.ObjectId, ref: 'Farmer', required: true },
    crop_category: { type: mongoose.Schema.Types.ObjectId, ref: 'CropCategory', required: false },
    child_crop_category: { type: mongoose.Schema.Types.ObjectId, ref: 'CropCategory', required: false },
    quantity: { type: Number },
    pickup_location: { type: String},
    price: { type: Number},
    total: Number,
    created_at: { type: Date },
    accepted_at: { type: Date },
    
    checkFlag: {type: Boolean, default: false},
    bidFlag: {type: Boolean, default: false},
    cancelFlag:{type: Boolean, default: false},
    status: { type: String }
});

module.exports = mongoose.model('CropBid', CropBidSchema);