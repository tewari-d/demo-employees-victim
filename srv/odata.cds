using { Employee as EmployeeTable } from '../db/tables';

service EmployeeService {

    entity Employee as projection on EmployeeTable;

}
