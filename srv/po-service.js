const cds = require("@sap/cds");
const { calculatePricing } = require("./po-pricing");

module.exports = cds.service.impl(function () {

    this.before("SAVE", "PurchaseOrders", async (req) => {
        calculatePricing(req.data);
    });

});
