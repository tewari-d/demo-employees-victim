const { validateAge } = require("./employee-utils");

function validateEmployee(employee) {

    if (!employee.Name) {
        throw new Error("Employee name is required");
    }

    validateAge(employee.Age);

    return true;
}

module.exports = {
    validateEmployee
};