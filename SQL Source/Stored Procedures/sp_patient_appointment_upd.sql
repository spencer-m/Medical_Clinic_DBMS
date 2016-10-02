use HealthcareClinic;
drop procedure if exists sp_patient_appointment_upd;

delimiter go
create procedure sp_patient_appointment_upd(
       in p_Appt_id        int
      ,in p_Patient_id     int
      ,in p_Doctor_id      int
      ,in p_Employee_id    int
      ,in p_Date           datetime
      ,in p_Reason         varchar(2000)
      ,in p_Doctor         varchar(100)
      ,in p_Nurse          varchar(100)
      ,in p_Family_dr      varchar(10)
      ,in p_Walkin         varchar(10)
      ,in p_Invoice_number int
      ,in p_Amount         decimal(15,2)
      ,in p_Balance        decimal(15,2)
      ,in p_Paid           decimal(15,2)
)
begin
set p_Amount = nullif(p_Amount, -1);
set p_Balance = nullif(p_Balance, -1);
set p_Paid = nullif(p_Paid, -1);
set p_Invoice_number = nullif(p_Invoice_number, -1);
set p_Doctor_id = nullif(p_Doctor_id, -1);
set p_Employee_id = nullif(p_Employee_id, -1);

update Appointment
   set Date = case when p_Date = ''
                   then Date
                   else p_Date
               end
      ,Employee_id = case when p_Nurse = ''
                          then Employee_id
                          else p_Employee_id
                      end
      ,Doctor_id = case when p_Doctor = ''
                        then Doctor_id
                        else p_Doctor_id
                    end
      ,Family_dr_flag = case when p_Family_dr = ''
                             then Family_dr_flag
                             else case when p_Family_dr = 'Yes'
                                       then 'Y'
                                       else 'N'
                                   end
                         end
      ,Walkin_flag = case when p_Walkin = ''
                          then Walkin_flag
                          else case when p_Walkin = 'Yes'
                                    then 'Y'
                                    else 'N'
                                end
                      end
      ,Reason = case when p_Reason = ''
                     then Reason
                     else p_Reason
                 end
      ,Revision_user = user()
      ,Revision_date = now()
 where ID = p_Appt_id;
 

update Billing
   set Amount = case when p_Amount is null
                     then Amount
                     else p_Amount 
                 end
      ,Balance = case when p_Balance is null
                      then Balance
                      else p_Balance
                  end
      ,Paid = case when p_Paid is null
                   then Paid
                   else p_Paid
               end
      ,Revision_user = user()
      ,Revision_date = now()
 where Invoice_number = p_Invoice_number;
                     

end go
delimiter ;

