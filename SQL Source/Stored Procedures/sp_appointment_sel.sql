use HealthcareClinic;
drop procedure if exists sp_appointment_sel;

delimiter go
create procedure sp_appointment_sel(
       in p_doctor_id  int
      ,in p_start_date datetime
      ,in p_end_date   datetime
      ,in p_patient_id int
)
begin

set p_start_date = nullif(p_start_date, '');
set p_end_date = nullif(p_end_date, '');

if p_doctor_id <> -1 and p_patient_id = 0 then
    select a.ID
          ,a.Date
          ,concat(p.First_name, ' ', p.Last_name) as Patient
          ,p.ID as Patient_id
          ,case when e2.First_name is null
				then 'N/A'
                else concat(e2.First_name, ' ', e2.Last_name) 
			end as Nurse
          ,a.Reason
          ,case when a.Family_dr_flag = 'Y'
                then 'Yes'
                else 'No'
            end as Family_dr_flag
          ,case when a.Walkin_flag = 'Y'
                then 'Yes'
                else 'No'
            end as Walkin_flag
          ,case when a.Invoice_number is null
                then 'N/A'
                else a.Invoice_number
            end as Invoice_number
          ,a.Revision_date
      from Patient as p
           inner join Appointment as a
                   on p.ID = a.Patient_id
           inner join Employee as e
                   on a.Doctor_id = e.Doctor_id
           left outer join Employee as e2
                   on a.Employee_id = e2.Employee_id           
     where a.Doctor_id = p_doctor_id
       and a.Date between p_start_date and date_add(p_end_date, interval 1 day)
       and not exists (select *
                        from Medical_History as mh
                       where mh.Doctor_id = a.Doctor_id
                         and mh.Appointment_date = a.Date
                         and mh.Patient_id = a.Patient_id)
     order by a.Date;
elseif p_doctor_id = -1 and p_patient_id = 0 then
   select a.ID
          ,a.Date
          ,concat(p.First_name, ' ', p.Last_name) as Patient
          ,p.ID as Patient_id
          ,case when e2.First_name is null
				then 'N/A'
                else concat(e2.First_name, ' ', e2.Last_name) 
			end as Nurse
          ,a.Reason
          ,case when a.Family_dr_flag = 'Y'
                then 'Yes'
                else 'No'
            end as Family_dr_flag
          ,case when a.Walkin_flag = 'Y'
                then 'Yes'
                else 'No'
            end as Walkin_flag
          ,case when a.Invoice_number is null
                then 'N/A'
                else a.Invoice_number
            end as Invoice_number
          ,a.Revision_date
      from Patient as p
           inner join Appointment as a
                   on p.ID = a.Patient_id
           inner join Employee as e
                   on a.Doctor_id = e.Doctor_id
           left outer join Employee as e2
                   on a.Employee_id = e2.Employee_id           
     where a.Date between p_start_date and date_add(p_end_date, interval 1 day)
       and not exists (select *
                        from Medical_History as mh
                       where mh.Doctor_id = a.Doctor_id
                         and mh.Appointment_date = a.Date
                         and mh.Patient_id = a.Patient_id)
     order by a.Date;
     
elseif p_doctor_id = -2 and p_patient_id <> 0 then
   if p_start_date is not null and p_end_date is not null then
   
      select a.ID
             ,a.Date
             ,concat(e.First_name, ' ', e.Last_name) as Doctor
             ,p.ID as Patient_id
             ,case when e2.First_name is null
				   then 'N/A'
                   else concat(e2.First_name, ' ', e2.Last_name) 
			   end as Nurse
             ,a.Reason          
             ,case when a.Invoice_number is null
                   then 'N/A'
                   else a.Invoice_number
               end as Invoice_number
             ,a.Revision_date
         from Patient as p
              inner join Appointment as a
                      on p.ID = a.Patient_id
              inner join Employee as e
                      on a.Doctor_id = e.Doctor_id
              left outer join Employee as e2
                      on a.Employee_id = e2.Employee_id           
        where a.Patient_id = p_patient_id
          and a.Date between p_start_date and date_add(p_end_date, interval 1 day)
          and not exists (select *
                            from Medical_History as mh
                           where mh.Doctor_id = a.Doctor_id
                             and mh.Appointment_date = a.Date
                             and mh.Patient_id = p_patient_id)
        order by a.Date;
    elseif p_start_date is null and p_end_date is not null then
    
       select a.ID
              ,a.Date
              ,concat(e.First_name, ' ', e.Last_name) as Doctor
              ,p.ID as Patient_id
              ,case when e2.First_name is null
				    then 'N/A'
                    else concat(e2.First_name, ' ', e2.Last_name) 
			    end as Nurse
              ,a.Reason          
              ,case when a.Invoice_number is null
                    then 'N/A'
                    else a.Invoice_number
                end as Invoice_number
              ,a.Revision_date
          from Patient as p
               inner join Appointment as a
                       on p.ID = a.Patient_id
               inner join Employee as e
                       on a.Doctor_id = e.Doctor_id
               left outer join Employee as e2
                       on a.Employee_id = e2.Employee_id           
         where a.Patient_id = p_patient_id
           and a.Date <= p_end_date
           and not exists (select *
                             from Medical_History as mh
                            where mh.Doctor_id = a.Doctor_id
                              and mh.Appointment_date = a.Date
                              and mh.Patient_id = p_patient_id)
         order by a.Date;
         
     elseif p_start_date is not null and p_end_date is null then
     
        select a.ID
              ,a.Date
              ,concat(e.First_name, ' ', e.Last_name) as Doctor
              ,p.ID as Patient_id
              ,case when e2.First_name is null
				    then 'N/A'
                    else concat(e2.First_name, ' ', e2.Last_name) 
			    end as Nurse
              ,a.Reason          
              ,case when a.Invoice_number is null
                    then 'N/A'
                    else a.Invoice_number
                end as Invoice_number
              ,a.Revision_date
          from Patient as p
               inner join Appointment as a
                       on p.ID = a.Patient_id
               inner join Employee as e
                       on a.Doctor_id = e.Doctor_id
               left outer join Employee as e2
                       on a.Employee_id = e2.Employee_id           
         where a.Patient_id = p_patient_id
           and a.Date >= p_start_date
           and not exists (select *
                             from Medical_History as mh
                            where mh.Doctor_id = a.Doctor_id
                              and mh.Appointment_date = a.Date
                              and mh.Patient_id = p_patient_id)
         order by a.Date;
     else
        select a.ID
               ,a.Date
               ,concat(e.First_name, ' ', e.Last_name) as Doctor
               ,p.ID as Patient_id
               ,case when e2.First_name is null
				     then 'N/A'
                     else concat(e2.First_name, ' ', e2.Last_name) 
			     end as Nurse
               ,a.Reason          
               ,case when a.Invoice_number is null
                     then 'N/A'
                     else a.Invoice_number
                 end as Invoice_number
               ,a.Revision_date
           from Patient as p
                inner join Appointment as a
                        on p.ID = a.Patient_id
                inner join Employee as e
                        on a.Doctor_id = e.Doctor_id
                left outer join Employee as e2
                        on a.Employee_id = e2.Employee_id           
          where a.Patient_id = p_patient_id            
            and not exists (select *
                              from Medical_History as mh
                             where mh.Doctor_id = a.Doctor_id
                               and mh.Appointment_date = a.Date
                               and mh.Patient_id = p_patient_id)
          order by a.Date;
       
     end if;
     
end if;

end go
delimiter ;

