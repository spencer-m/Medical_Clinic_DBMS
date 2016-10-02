/*
Procedure: Get patient data given the first name and last name and/or patient id.
*/

use HealthcareClinic;
drop procedure if exists sp_doctor_patient_sel;

delimiter go
create procedure sp_doctor_patient_sel (
	 in p_first_name	varchar(50)
	,in p_last_name	varchar(50)
	,in p_patient_id	int
)
begin

	select First_name
		,Last_name
		,Health_care_number
		,Allergies
		,Address
		,Phone_number
		from Patient as p
		where (p.First_name = p_first_name and p.Last_name = p_last_name)
				or p.Patient_id = p_patient_id;

end go
delimiter ;

