namespace sap.demo.po;

using {
    managed,
    cuid
} from '@sap/cds/common';

/**
 * Purchase order header. Field selection follows the ME21N document header so the
 * Fiori application reads like a standard purchasing transaction.
 */
entity PurchaseOrders : managed, cuid {
    PurchaseOrderNo   : String(10);
    DocumentType      : String(4);
    Status            : String(2);
    Supplier          : String(10);
    SupplierName      : String(80);
    CompanyCode       : String(4);
    PurchasingOrg     : String(4);
    PurchasingGroup   : String(3);
    DocumentDate      : Date;
    DeliveryDate      : Date;
    CurrencyCode      : String(3);
    PaymentTerms      : String(4);
    IncotermsCode     : String(3);
    IncotermsLocation : String(28);
    OurReference      : String(20);

    // Tax determination. CountryKey is the reporting country of the purchasing
    // company code; ReverseCharge selects the alternative EU determination.
    CountryKey        : String(3) default 'DE';
    ReverseCharge     : Boolean default false;

    // Calculated in srv/po-pricing.js on create.
    NetAmount         : Decimal(15, 2);
    TaxAmount         : Decimal(15, 2);
    GrossAmount       : Decimal(15, 2);

    items             : Composition of many PurchaseOrderItems
                            on items.parent = $self;
}

entity PurchaseOrderItems : cuid {
    parent            : Association to PurchaseOrders;
    ItemNumber        : Integer;
    Material          : String(18);
    Description       : String(40);
    MaterialGroup     : String(9);
    Plant             : String(4);
    StorageLocation   : String(4);
    Quantity          : Decimal(13, 3);
    OrderUnit         : String(3);
    NetPrice          : Decimal(11, 2);
    PriceUnit         : Integer;
    NetValue          : Decimal(15, 2);
    TaxCode           : String(2);
    TaxAmount         : Decimal(15, 2);
    DeliveryDate      : Date;
    AccountAssignment : String(1);
    ItemCategory      : String(1);
}

// ---------------------------------------------------------------------------
// Master data, exposed read-only purely to drive the value helps.
// ---------------------------------------------------------------------------

entity Suppliers {
    key SupplierNo : String(10);
        Name       : String(80);
        CountryKey : String(3);
        City       : String(40);
}

entity Materials {
    key MaterialNo    : String(18);
        Description   : String(40);
        MaterialGroup : String(9);
        BaseUnit      : String(3);
}

entity Plants {
    key PlantCode  : String(4);
        Name       : String(40);
        CountryKey : String(3);
}

entity DocumentTypes {
    key DocType     : String(4);
        Description : String(40);
}

entity POStatuses {
    key StatusCode  : String(2);
        Description : String(40);
}

entity TaxCountries {
    key CountryKey : String(3);
        Name       : String(40);
}
