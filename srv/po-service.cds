using { sap.demo.po as db } from '../db/po-schema';

service PurchaseOrderService {

    @odata.draft.enabled
    entity PurchaseOrders     as projection on db.PurchaseOrders;
    entity PurchaseOrderItems as projection on db.PurchaseOrderItems;

    @readonly
    entity Suppliers     as projection on db.Suppliers;

    @readonly
    entity Materials     as projection on db.Materials;

    @readonly
    entity Plants        as projection on db.Plants;

    @readonly
    entity DocumentTypes as projection on db.DocumentTypes;

    @readonly
    entity POStatuses    as projection on db.POStatuses;

    @readonly
    entity TaxCountries  as projection on db.TaxCountries;
}
