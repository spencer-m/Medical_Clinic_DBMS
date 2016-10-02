/*
Procedure: Update appointment entry
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_appointment_upd;

delimiter go
create procedure sp_doctor_appointment_upd (
	 in a_patient_id	int
	,in a_date	datetime
	,in a_room_number	int
	,in a_employee_id	int
	,in a_doctor_id	int
	,in a_family_dr_flag	varchar(1)
	,in a_walkin_flag	varchar(1)
	,in a_reason	varchar(2000)
)
begin

	update Appointment as a
				set   a.Room_number = a_room_number
						,a.Employee_id = a_employee_id
						,a.Doctor_id = a_doctor_id
						,a.Family_dr_flag = a_family_dr_flag
						,a.Walkin_flag = a_walkin_flag
						,a.Reason = a_reason
						,a.Revision_user = user()
						,a.Revision_date = now()
				where	a.Date = a_date
				and a.Patient_id = a_patient_id;

end go
delimiter ;

