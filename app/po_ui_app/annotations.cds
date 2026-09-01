using PurchaseOrderService as service from '../../srv/po-service';

// ---------------------------------------------------------------------------
// Labels
// ---------------------------------------------------------------------------

annotate service.PurchaseOrders with {
    PurchaseOrderNo   @title: 'Purchase Order';
    DocumentType      @title: 'Document Type';
    Status            @title: 'Status';
    Supplier          @title: 'Supplier';
    SupplierName      @title: 'Supplier Name';
    CompanyCode       @title: 'Company Code';
    PurchasingOrg     @title: 'Purchasing Organization';
    PurchasingGroup   @title: 'Purchasing Group';
    DocumentDate      @title: 'Document Date';
    DeliveryDate      @title: 'Delivery Date';
    CurrencyCode      @title: 'Currency';
    PaymentTerms      @title: 'Payment Terms';
    IncotermsCode     @title: 'Incoterms';
    IncotermsLocation @title: 'Incoterms Location';
    OurReference      @title: 'Our Reference';
    CountryKey        @title: 'Tax Country';
    ReverseCharge     @title: 'Reverse Charge';
    NetAmount         @title: 'Net Value'   @Measures.ISOCurrency: CurrencyCode;
    TaxAmount         @title: 'Tax Value'   @Measures.ISOCurrency: CurrencyCode;
    GrossAmount       @title: 'Gross Value' @Measures.ISOCurrency: CurrencyCode;
}

annotate service.PurchaseOrderItems with {
    ItemNumber        @title: 'Item';
    Material          @title: 'Material';
    Description       @title: 'Short Text';
    MaterialGroup     @title: 'Material Group';
    Plant             @title: 'Plant';
    StorageLocation   @title: 'Storage Location';
    Quantity          @title: 'Quantity';
    OrderUnit         @title: 'Order Unit';
    NetPrice          @title: 'Net Price';
    PriceUnit         @title: 'Per';
    NetValue          @title: 'Net Value';
    TaxCode           @title: 'Tax Code';
    TaxAmount         @title: 'Tax Value';
    DeliveryDate      @title: 'Delivery Date';
    AccountAssignment @title: 'Account Assignment';
    ItemCategory      @title: 'Item Category';
}

// ---------------------------------------------------------------------------
// List report and object page
// ---------------------------------------------------------------------------

annotate service.PurchaseOrders with @(UI: {
    HeaderInfo               : {
        TypeName      : 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title         : {Value: PurchaseOrderNo},
        Description   : {Value: SupplierName}
    },

    SelectionFields          : [
        PurchaseOrderNo,
        Supplier,
        DocumentType,
        Status,
        CompanyCode,
        PurchasingOrg,
        CountryKey
    ],

    LineItem                 : [
        {Value: PurchaseOrderNo},
        {Value: DocumentType},
        {Value: SupplierName},
        {Value: CompanyCode},
        {Value: PurchasingOrg},
        {Value: DocumentDate},
        {Value: NetAmount},
        {Value: GrossAmount},
        {Value: Status}
    ],

    DataPoint #NetValue      : {
        Value: NetAmount,
        Title: 'Net Value'
    },

    DataPoint #GrossValue    : {
        Value: GrossAmount,
        Title: 'Gross Value'
    },

    HeaderFacets             : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'NetValueFacet',
            Target: '@UI.DataPoint#NetValue'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GrossValueFacet',
            Target: '@UI.DataPoint#GrossValue'
        }
    ],

    Facets                   : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneralInformation',
            Label : 'General Information',
            Target: '@UI.FieldGroup#General'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'OrganisationalData',
            Label : 'Organizational Data',
            Target: '@UI.FieldGroup#Organisation'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'DeliveryAndTerms',
            Label : 'Delivery and Terms',
            Target: '@UI.FieldGroup#Delivery'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'TaxDetermination',
            Label : 'Tax Determination',
            Target: '@UI.FieldGroup#Tax'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'Items',
            Label : 'Items',
            Target: 'items/@UI.LineItem'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'Pricing',
            Label : 'Pricing',
            Target: '@UI.FieldGroup#Pricing'
        }
    ],

    FieldGroup #General      : {Data: [
        {Value: PurchaseOrderNo},
        {Value: DocumentType},
        {Value: Status},
        {Value: Supplier},
        {Value: SupplierName},
        {Value: DocumentDate},
        {Value: OurReference}
    ]},

    FieldGroup #Organisation : {Data: [
        {Value: CompanyCode},
        {Value: PurchasingOrg},
        {Value: PurchasingGroup},
        {Value: CurrencyCode}
    ]},

    FieldGroup #Delivery     : {Data: [
        {Value: DeliveryDate},
        {Value: PaymentTerms},
        {Value: IncotermsCode},
        {Value: IncotermsLocation}
    ]},

    FieldGroup #Tax          : {Data: [
        {Value: CountryKey},
        {Value: ReverseCharge}
    ]},

    FieldGroup #Pricing      : {Data: [
        {Value: NetAmount},
        {Value: TaxAmount},
        {Value: GrossAmount},
        {Value: CurrencyCode}
    ]}
});

annotate service.PurchaseOrderItems with @(UI: {
    HeaderInfo: {
        TypeName      : 'Item',
        TypeNamePlural: 'Items',
        Title         : {Value: Material},
        Description   : {Value: Description}
    },
    LineItem  : [
        {Value: ItemNumber},
        {Value: Material},
        {Value: Description},
        {Value: Plant},
        {Value: StorageLocation},
        {Value: Quantity},
        {Value: OrderUnit},
        {Value: NetPrice},
        {Value: PriceUnit},
        {Value: NetValue},
        {Value: TaxCode},
        {Value: DeliveryDate}
    ]
});

// ---------------------------------------------------------------------------
// Value helps
// ---------------------------------------------------------------------------

annotate service.PurchaseOrders with {
    Supplier     @(Common: {ValueList: {
        CollectionPath: 'Suppliers',
        Label         : 'Suppliers',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: Supplier,
                ValueListProperty: 'SupplierNo'
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: SupplierName,
                ValueListProperty: 'Name'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'CountryKey'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'City'
            }
        ]
    }});

    DocumentType @(Common: {
        ValueListWithFixedValues: true,
        ValueList               : {
            CollectionPath: 'DocumentTypes',
            Label         : 'Document Types',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: DocumentType,
                    ValueListProperty: 'DocType'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Description'
                }
            ]
        }
    });

    Status       @(Common: {
        ValueListWithFixedValues: true,
        ValueList               : {
            CollectionPath: 'POStatuses',
            Label         : 'Statuses',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: Status,
                    ValueListProperty: 'StatusCode'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Description'
                }
            ]
        }
    });

    CountryKey   @(Common: {
        ValueListWithFixedValues: true,
        ValueList               : {
            CollectionPath: 'TaxCountries',
            Label         : 'Tax Countries',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: CountryKey,
                    ValueListProperty: 'CountryKey'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Name'
                }
            ]
        }
    });
}

annotate service.PurchaseOrderItems with {
    Material @(Common: {ValueList: {
        CollectionPath: 'Materials',
        Label         : 'Materials',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: Material,
                ValueListProperty: 'MaterialNo'
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: Description,
                ValueListProperty: 'Description'
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: MaterialGroup,
                ValueListProperty: 'MaterialGroup'
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: OrderUnit,
                ValueListProperty: 'BaseUnit'
            }
        ]
    }});

    Plant    @(Common: {
        ValueListWithFixedValues: true,
        ValueList               : {
            CollectionPath: 'Plants',
            Label         : 'Plants',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: Plant,
                    ValueListProperty: 'PlantCode'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Name'
                }
            ]
        }
    });
}
