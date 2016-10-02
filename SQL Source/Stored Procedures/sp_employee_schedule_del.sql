use HealthcareClinic;
drop procedure if exists sp_employee_schedule_del;

delimiter go
create procedure sp_employee_schedule_del(
       in p_Employee_id    int
      ,in p_Work_day_date  datetime
)
begin

    delete from Scheduled_For
     where Employee_id = p_Employee_id
       and Work_day_date = p_Work_day_date;

end go
delimiter ;

