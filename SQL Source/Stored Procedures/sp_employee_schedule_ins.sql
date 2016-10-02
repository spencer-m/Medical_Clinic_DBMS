use HealthcareClinic;
drop procedure if exists sp_employee_schedule_ins;

delimiter go
create procedure sp_employee_schedule_ins (
       in Employee_id      int
      ,in Work_day_date    datetime
      ,in Start_time       datetime
      ,in End_time         datetime
)
begin
    insert into Work_Day(
           Date
          ,Start_time
          ,End_time
          ,Revision_user
          ,Revision_date
    )
    values(
           Work_day_date
          ,Start_time
          ,End_time
          ,user()
          ,now()
    );
    select Work_day_date;
    -- set FOREIGN_KEY_CHECKS = 0;
    insert into Scheduled_for (
           Employee_id
          ,Work_day_date
          ,Revision_user
          ,Revision_date
    )
    values(
           Employee_id
          ,Work_day_date
          ,user()
          ,now()
    );
    -- set FOREIGN_KEY_CHECKS = 1;

end go
delimiter ;

