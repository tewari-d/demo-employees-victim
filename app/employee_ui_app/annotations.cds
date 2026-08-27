using EmployeeService as service from '../../srv/employee-service';

annotate service.Employee with {
    Name     @title: 'Name';
    SirName  @title: 'Surname';
    Age      @title: 'Age';
    Location @title: 'Location';
}

annotate service.Employee with @(UI: {
    HeaderInfo: {
        TypeName      : 'Employee',
        TypeNamePlural: 'Employees',
        Title         : {Value: Name},
        Description   : {Value: SirName}
    },
    LineItem  : [
        {Value: Name},
        {Value: SirName},
        {Value: Age},
        {Value: Location}
    ]
});
