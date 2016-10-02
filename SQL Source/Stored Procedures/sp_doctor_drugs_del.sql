/*
Procedure: Delete a drug entry using DIN
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_drugs_del;

delimiter go
create procedure sp_doctor_drugs_del (
		in	d_id	int
)
begin

	delete from Drugs_Available
			where Drugs_Available.Drug_ID = d_id;


end go
delimiter ;

