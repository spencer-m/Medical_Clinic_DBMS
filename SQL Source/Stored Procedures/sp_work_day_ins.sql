use HealthcareClinic;
drop procedure if exists sp_work_day_ins;

delimiter go
create procedure sp_work_day_ins (
       in Date        datetime
      ,in Start_time  datetime
      ,in End_time    datetime
)
begin

    insert into Work_day(
           Date
          ,Start_time
          ,End_time
          ,Revision_user
          ,Revision_date
    )
    values(
           Date
          ,Start_time
          ,End_time
          ,user()
          ,now()
    );
    
end go
delimiter ;

