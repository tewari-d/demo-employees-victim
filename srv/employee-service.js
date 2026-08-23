const cds = require("@sap/cds");
const { validateEmployee } = require("./employee-validator");

module.exports = cds.service.impl(function () {

    this.before("CREATE", "Employee", async (req) => {

        const employee = req.data;
        if (employee.Age == 33)
            validateEmployee(employee);
    });

});