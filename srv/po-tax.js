const {
    standardRateFor,
    reverseChargeRateFor
} = require("./po-config");

/**
 * Selects the tax determination for a purchase order.
 *
 * Domestic and import purchases are taxed at the standard rate of the reporting
 * country. Intra-community purchases where the liability shifts to the recipient
 * are determined under the reverse charge scheme instead.
 */
function resolveTaxRate(countryKey, isReverseCharge) {

    if (isReverseCharge) {
        return reverseChargeRateFor(countryKey);
    }

    return standardRateFor(countryKey);
}

module.exports = {
    resolveTaxRate
};
