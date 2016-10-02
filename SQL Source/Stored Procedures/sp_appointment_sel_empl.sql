use HealthcareClinic;
drop procedure if exists sp_appointment_sel_empl;

delimiter go
create procedure sp_appointment_sel_empl(
       in beginTime datetime,
       in endTime datetime,
       in eid int
)
begin

    select w.Start_time, w.End_time, e.First_name, e.Last_name
      from scheduled_for as s
		inner join work_day as w
        inner join employee as e
     where s.Work_day_date BETWEEN beginTime AND endTime
     and s.Employee_id = eid 
     and w.Date = s.Work_day_date
     and eid = e.Employee_id;

end go
delimiter ;

