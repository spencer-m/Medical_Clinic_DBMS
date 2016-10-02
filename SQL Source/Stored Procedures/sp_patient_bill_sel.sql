/*
Procedure: select and view the bill(s) for a certain patient
*/
use HealthcareClinic;
drop procedure if exists sp_patient_bill_sel;

delimiter go
create procedure sp_patient_bill_sel(
       in Patient_id  int
      ,in Date        datetime
)
begin

select p.First_name
      ,p.Last_name
      ,b.Invoice_number
      ,b.Amount
      ,b.Balance
      ,b.Paid
      ,a.Date
  from Billing as b
       inner join Appointment as a
               on b.Invoice_number = a.Invoice_number
       inner join Patient as p
               on a.Patient_id = p.Patient_id
 where a.Patient_id = Patient_id
   and a.Date = Date;

end go
delimiter ;

