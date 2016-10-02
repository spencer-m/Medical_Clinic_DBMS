/*
Procedure: Find patient from ID
*/
use HealthcareClinic;
drop procedure if exists sp_patient_sel_ID;

delimiter go
create procedure sp_patient_sel_ID(
       in p_ID          int(11)
)
begin
    select 
          First_name
          ,Last_name
          
      from Patient
     where ID = p_ID;
end go
delimiter ;

