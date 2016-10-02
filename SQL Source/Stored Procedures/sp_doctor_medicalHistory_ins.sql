/*
Procedure: Insert an entry to Medical_History
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_medicalHistory_ins;

delimiter go
create procedure sp_doctor_medicalHistory_ins (
       in p_appt_id    int
      ,in p_comments   varchar(250)
      ,in p_amount     decimal(15,2)
      ,in p_balance    decimal(15,2)      
)
begin
declare last_inserted int;
	insert into Medical_History (
						 Doctor_ID
						,Appointment_date
						,Patient_id
						,Walkin_flag
						,Family_dr_flag
						,Comments
						,Reason_for_appt
						,Revision_user
						,Revision_date
	)
 select Doctor_id
       ,Date
       ,Patient_id
       ,Walkin_flag
       ,Family_dr_flag
       ,p_comments
       ,Reason
       ,user()
       ,now()
   from Appointment
  where ID = p_appt_id;
set last_inserted = last_insert_id();
 call sp_patient_bill_ins(p_appt_id, p_amount, p_balance, 0);

select last_inserted;

end go
delimiter ;

