use HealthcareClinic;
drop procedure if exists sp_appointment_del;

delimiter go
create procedure sp_appointment_del(
       in p_Patient_id  int
      ,in p_Date          datetime
)
begin

    delete from Appointment
     where Patient_id = p_Patient_id
       and Date = p_Date;

end go
delimiter ;

