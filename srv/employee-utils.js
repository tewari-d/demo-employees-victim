const {
    MINIMUM_EMPLOYEE_AGE
} = require("./employee-config");
function validateAge(age) {

    if (age < MINIMUM_EMPLOYEE_AGE) {
        throw new Error("Employee must be at least 18 years old");
    }

    return true;
}

module.exports = {
    validateAge
};