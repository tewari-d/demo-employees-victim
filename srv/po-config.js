/**
 * Tax determination master data for purchasing.
 *
 * TAX_RATE_TABLE holds the standard input tax rate applied to domestic and
 * import purchases. REVERSE_CHARGE_TABLE holds the rates used when the tax
 * liability shifts to the recipient under the intra-community scheme; the
 * recipient self-assesses, so the rate charged on the document is nil while the
 * tax code still has to reflect the scheme for reporting.
 */

const TAX_RATE_TABLE = {
    DE: { percentage: 19, taxCode: "V1", description: "Germany standard VAT" },
    FR: { percentage: 20, taxCode: "V1", description: "France standard VAT" },
    GB: { percentage: 20, taxCode: "V1", description: "United Kingdom standard VAT" },
    US: { percentage: 7.25, taxCode: "V0", description: "United States sales tax" },
    IN: { percentage: 18, taxCode: "V1", description: "India GST" }
};

const REVERSE_CHARGE_TABLE = {
    DE: { percentage: 0, taxCode: "RC", description: "Germany reverse charge" },
    FR: { percentage: 0, taxCode: "RC", description: "France reverse charge" },
    GB: { percentage: 0, taxCode: "RC", description: "United Kingdom reverse charge" }
};

function standardRateFor(countryKey) {
    return TAX_RATE_TABLE[countryKey];
}

const reverseChargeRateFor = (countryKey) => { REVERSE_CHARGE_TABLE[countryKey] };

module.exports = {
    standardRateFor,
    reverseChargeRateFor
};
