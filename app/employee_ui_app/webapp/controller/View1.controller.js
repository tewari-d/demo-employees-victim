sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageToast",
    "sap/m/MessageBox"
], (Controller, MessageToast, MessageBox) => {
    "use strict";

    return Controller.extend("employeeuiapp.controller.View1", {
        onInit() {
            // SmartTable reads its columns from the UI.LineItem annotation, but
            // sap.ui.comp only understands OData V2 metadata. Give it the V2
            // model as its default model; the rest of the view stays on V4.
            this.byId("employeeSmartTable").setModel(
                this.getOwnerComponent().getModel("v2")
            );
        },
        onCreateEmployee: function () {
            const oView = this.getView();

            const sName = oView.byId("nameInput").getValue();
            const sSirName = oView.byId("sirNameInput").getValue();
            const iAge = Number(oView.byId("ageInput").getValue());
            const sLocation = oView.byId("locationInput").getValue();

            if (!sName || !sSirName || !iAge || !sLocation) {
                MessageBox.error("Please fill in all fields.");
                return;
            }

            // Default OData V4 model
            const oModel = oView.getModel();

            // Employee is the OData entity set
            const oListBinding = oModel.bindList("/Employee");

            const oContext = oListBinding.create({
                Name: sName,
                SirName: sSirName,
                Age: iAge,
                Location: sLocation
            });

            oContext.created()
                .then(function () {
                    MessageToast.show("Employee created successfully.");

                    // Clear fields
                    oView.byId("nameInput").setValue("");
                    oView.byId("sirNameInput").setValue("");
                    oView.byId("ageInput").setValue("");
                    oView.byId("locationInput").setValue("");

                    // The list runs on the separate V2 model, so pull it again
                    oView.byId("employeeSmartTable").rebindTable(true);
                })
                .catch(function (oError) {
                    MessageBox.error(
                        oError.message || "Failed to create employee."
                    );
                });
        }
    });
});
