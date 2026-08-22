using {
    managed,
    cuid
} from '@sap/cds/common';

entity Employee : managed, cuid {
    Name     : String(20);
    SirName  : String(20);
    Age      : Integer;
    Location : String(10);
}