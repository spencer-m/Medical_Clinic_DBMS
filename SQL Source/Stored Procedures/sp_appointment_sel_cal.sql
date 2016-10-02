use HealthcareClinic;
drop procedure if exists sp_appointment_sel_cal;

delimiter go
create procedure sp_appointment_sel_cal(
       in beginTime datetime,
       in endTime datetime,
       in did int
)
begin

    select *
      from Appointment as a
     where a.date BETWEEN beginTime AND endTime
     and a.Doctor_id = did;

end go
delimiter ;

