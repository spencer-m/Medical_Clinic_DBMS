use HealthcareClinic;
drop procedure if exists sp_pay_patient_bill;

delimiter go
create procedure sp_pay_patient_bill(
       in p_Patient_id  int
      ,in p_Date        datetime
      ,in p_Amount_paid decimal(15,2)
) 
begin

    update Billing as b
       set b.Balance = b.Balance - p_Amount_paid
          ,b.Paid = b.Amount - b.Balance
     where Invoice_number in (select Invoice_number
                                from Appointment as p
                               where p.Patient_id = p_Patient_id
                                 and p.Date = p_Date);
                                 
end go
delimiter ;

