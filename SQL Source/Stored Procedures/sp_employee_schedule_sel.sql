/*
Procedure: update employee attributes
*/
use HealthcareClinic;
drop procedure if exists sp_employee_schedule_sel;

delimiter go
create procedure sp_employee_schedule_sel(
       in Employee_id    int
      ,in Work_day_date  datetime
)
begin

select w.Start_time
      ,w.End_time
  from Employee as e
       inner join Scheduled_for as sf
               on e.Employee_id = sf.Employee_id
       inner join Work_day as w
               on sf.work_day_date = w.date;

end go
delimiter ;

