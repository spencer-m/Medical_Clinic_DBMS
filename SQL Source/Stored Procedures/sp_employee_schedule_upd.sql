use HealthcareClinic;
drop procedure if exists sp_employee_schedule_upd;

delimiter go
create procedure sp_employee_schedule_upd(
       in Employee_id     int
      ,in Work_day_date   datetime
      ,in New_date        datetime
)
begin

    update Scheduled_For
       set Work_day_date = New_date
     where Employee_id = Employee_id
       and Work_day_date = Work_day_date;

end go
delimiter ;

