drop procedure if exists sp_employee_del;
delimiter //
create procedure sp_employee_del(
      in `Employee_id` int
)
begin

    delete from Employee
     where Employee_id = Employee_id;

end //
delimiter ;

