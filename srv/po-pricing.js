const { resolveTaxRate } = require("./po-tax");

/**
 * Values a purchase order: net value per item, then tax, then the document totals.
 * Called from the CREATE handler before the order is persisted.
 *
 * The tax rate is determined once for the document rather than per item, because
 * every item of a purchase order is taxed under the same determination.
 */
function calculatePricing(order) {

    const rate = resolveTaxRate(order.CountryKey, order.ReverseCharge);
    const taxPercentage = rate?.percentage ?? 0;
    const taxCode = rate?.taxCode;

    const items = order.items || [];
    let netTotal = 0;
    let taxTotal = 0;

    for (const item of items) {
        const priceUnit = item.PriceUnit || 1;
        item.NetValue = round(item.Quantity * item.NetPrice / priceUnit);
        item.TaxAmount = round(item.NetValue * taxPercentage / 100);
        item.TaxCode = taxCode;

        netTotal += item.NetValue;
        taxTotal += item.TaxAmount;
    }

    order.NetAmount = round(netTotal);
    order.TaxAmount = round(taxTotal);
    order.GrossAmount = round(netTotal + taxTotal);

    return order;
}

function round(value) {
    return Math.round((Number(value) || 0) * 100) / 100;
}

module.exports = {
    calculatePricing
};
