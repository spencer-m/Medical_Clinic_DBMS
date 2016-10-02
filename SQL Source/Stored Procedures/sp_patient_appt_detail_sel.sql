use HealthcareClinic;
drop procedure if exists sp_patient_appt_detail_sel;

delimiter go
create procedure sp_patient_appt_detail_sel(
       in p_Patient_id    int
      ,in p_Start_date    datetime
      ,in p_End_date      datetime
      ,in p_Doctor_lname  varchar(50)
      ,in p_Balance       decimal(15,2)
)
begin
set p_Start_date = nullif(p_Start_date, '' or '0000-00-00 00:00:00');
set p_End_date = nullif(p_End_date, '' or '0000-00-00 00:00:00');
set p_Doctor_lname = nullif(p_Doctor_lname, '');
set p_Balance = nullif(p_Balance, -1.0);

if (p_Patient_id is not null
    and p_Start_date is null
    and p_End_date is null
    and p_Doctor_lname is null
    and p_Balance is null) then
    
    select a.Date
          ,concat(d.First_name, ' ', d.Last_name) as Doctor
          ,d.Doctor_id
          ,concat(e.First_name, ' ', e.Last_name) as Nurse
          ,a.Reason
          ,a.Family_dr_flag
          ,a.Walkin_flag
          ,a.Invoice_number
          ,b.Amount
          ,b.Balance
          ,b.Paid
          ,a.Revision_date
      from Patient as p
           inner join Appointment as a
                   on p.ID = a.Patient_id
           inner join Employee as d
                   on a.Doctor_id = d.Doctor_id
           left outer join Employee as e
                        on a.Employee_id = e.Employee_id
           left outer join Billing as b
                        on a.Invoice_number = b.Invoice_number
     where p.ID = p_Patient_id
       and not exists (Select *
                     from Medical_History as mh
                    where a.Date = mh.Appointment_date
                      and a.Patient_id = mh.Patient_id
                      and a.Doctor_id = mh.Doctor_id)
     order by a.Date;

elseif (p_Patient_id is not null 
        and p_Start_date is not null
        and p_End_date is not null
        and p_Doctor_lname is null
        and p_Balance is null) then
        
     select a.Date
          ,concat(d.First_name, ' ', d.Last_name) as Doctor
          ,d.Doctor_id
          ,concat(e.First_name, ' ', e.Last_name) as Nurse
          ,a.Reason
          ,a.Family_dr_flag
          ,a.Walkin_flag
          ,a.Invoice_number
          ,b.Amount
          ,b.Balance
          ,b.Paid
          ,a.Revision_date
      from Patient as p
           inner join Appointment as a
                   on p.ID = a.Patient_id
           inner join Employee as d
                   on a.Doctor_id = d.Doctor_id        
           inner join Employee as e
                   on a.Employee_id = e.Employee_id
           left outer join Billing as b
                        on a.Invoice_number = b.Invoice_number
     where p.ID = p_Patient_id
       and a.Date between p_Start_date and date_add(p_End_date, interval 1 day)
       and not exists (Select *
                     from Medical_History as mh
                    where a.Date = mh.Appointment_date
                      and a.Patient_id = mh.Patient_id
                      and a.Doctor_id = mh.Doctor_id)
     order by a.Date;

elseif (p_Patient_id is not null
        and p_Doctor_lname is not null
        and p_Start_date is null
        and p_End_date is null
        and p_Balance is null) then
    set p_Doctor_lname = concat('%', p_Doctor_lname, '%');
    select a.Date
          ,concat(d.First_name, ' ', d.Last_name) as Doctor
          ,d.Doctor_id
          ,concat(e.First_name, ' ', e.Last_name) as Nurse
          ,a.Reason
          ,a.Family_dr_flag
          ,a.Walkin_flag
          ,a.Invoice_number
          ,b.Amount
          ,b.Balance
          ,b.Paid
          ,a.Revision_date
      from Patient as p
           inner join Appointment as a
                   on p.ID = a.Patient_id
           inner join Employee as d
                   on a.Doctor_id = d.Doctor_id        
           inner join Employee as e
                   on a.Employee_id = e.Employee_id
           left outer join Billing as b
                        on a.Invoice_number = b.Invoice_number
     where p.ID = p_Patient_id
       and d.Last_name like p_Doctor_lname
       and not exists (Select *
                     from Medical_History as mh
                    where a.Date = mh.Appointment_date
                      and a.Patient_id = mh.Patient_id
                      and a.Doctor_id = mh.Doctor_id)
     order by a.Date;
    
 elseif (p_Patient_id is not null
         and p_Balance is not null
         and p_Start_date is null
         and p_End_date is null
         and p_Doctor_lname is null) then
         
    select a.Date
          ,concat(d.First_name, ' ', d.Last_name) as Doctor
          ,d.Doctor_id
          ,concat(e.First_name, ' ', e.Last_name) as Nurse
          ,a.Reason
          ,a.Family_dr_flag
          ,a.Walkin_flag
          ,a.Invoice_number
          ,b.Amount
          ,b.Balance
          ,b.Paid
          ,a.Revision_date
      from Patient as p
           inner join Appointment as a
                   on p.ID = a.Patient_id
           inner join Employee as d
                   on a.Doctor_id = d.Doctor_id        
           inner join Employee as e
                   on a.Employee_id = e.Employee_id
           inner join Billing as b
                        on a.Invoice_number = b.Invoice_number
     where p.ID = p_Patient_id
       and b.Balance = p_Balance
       and not exists (Select *
                     from Medical_History as mh
                    where a.Date = mh.Appointment_date
                      and a.Patient_id = mh.Patient_id
                      and a.Doctor_id = mh.Doctor_id)
     order by a.Date;

end if;
    
end go
delimiter ;

