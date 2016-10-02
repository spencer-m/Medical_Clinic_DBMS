use HealthcareClinic;
drop procedure if exists sp_patient_bill_ins;

delimiter go
create procedure sp_patient_bill_ins(
       -- in Patient_id   int
      -- ,in Date         datetime
       in p_appt_id      int
      ,in p_Amount       decimal(15,2)
      ,in p_Balance      decimal(15,2)
      ,in p_Paid         decimal(15,2)
)
begin
    if p_Paid is null then
       set p_Paid = 0;
    end if;
    insert into Billing(
           Amount
          ,Balance
          ,Paid
          ,Revision_user
          ,Revision_date
    )
    values(
           p_Amount
          ,p_Balance = case when p_Paid > 0
                          then p_Amount - p_Paid
                          else p_Balance
                      end
          ,p_Paid
          ,user()
          ,now()         
    );

    update Appointment as a
       set Invoice_number = last_insert_id()
          ,Revision_user = user()
          ,Revision_date = now()
     where ID = p_appt_id;
     -- where a.Patient_id = Patient_id
     --   and a.Date = Date;

end go
delimiter ;

