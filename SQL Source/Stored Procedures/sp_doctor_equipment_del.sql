/*
Procedure: Delete an equipment entry
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_equipment_del;

delimiter go
create procedure sp_doctor_equipment_del (
	 in e_id	int
)
begin

	delete e
		from Equipment as e join Room_Equipment_Xref as rex
			on e.Equipment_ID = rex.Equipment_ID
		where e.Equipment_ID = e_id;

end go
delimiter ;

