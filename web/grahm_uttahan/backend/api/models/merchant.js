const mongoose = require('mongoose');

const merchantSchema = mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    email: { 
        type: String,
        match: /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    },
    first_name: {type: String },
    last_name: {type: String },
    gender: {type: String },
    aadhar_no: { type: Number},
    merchant_licence: { type: String},
    contact_no: { type: Number, unique: true, required: true},
    age: {type: Number},
    address : String,
        
    disabled:{type:Boolean, default: false},
    verifyEmail:{type:Boolean, default: false},
    verifyEmailToken: String,
    password: { type: String},
    otpToken: String,
    otpExpires: Date,

    resetEmailToken: String,
    resetEmailExpires: Date,
    
    resetMobileToken: String,
    resetMobileExpires: Date
});

module.exports = mongoose.model('Merchant', merchantSchema);