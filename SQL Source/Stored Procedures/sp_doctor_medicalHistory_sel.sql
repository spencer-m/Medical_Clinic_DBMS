/*
Procedure: Get Medical_History of a patient
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_medicalHistory_sel;

delimiter go
create procedure sp_doctor_medicalHistory_sel (
       in p_patient_id   int
      ,in p_doctor_lname	varchar(50)
      ,in p_start_date	  datetime
      ,in p_end_date     datetime
)
begin

declare prescriptions_and_refills varchar(250) default '';
declare p varchar(250) default '';
declare finished int default 0;
declare previous_id int default 0;

declare mh_id int default 0;
declare d_name varchar(50) default '';
declare d_refills int default 0;

declare drugs_cursor cursor for
select mhdx.Medical_history_id
      ,da.Name
      ,mhdx.Refills
  from Medical_Hist_Drug_Xref as mhdx
       inner join Drugs_Available da
               on mhdx.Drug_id = da.Drug_id;

declare continue handler for not found set finished = 1;
drop temporary table if exists pres_and_ref;
create temporary table pres_and_ref (
       id  int
      ,p_and_r varchar (250)
);

open drugs_cursor;

get_drug: loop

fetch drugs_cursor into mh_id, d_name, d_refills;

if finished = 1 then
leave get_drug;
end if;

-- if the previous_id is 0, then we are just starting our cursor...
if previous_id = 0 then
   -- concatenate each record as Drug (refill), Drug (refill), ...
   set prescriptions_and_refills = concat(d_name, ' (', d_refills, '), ', prescriptions_and_refills);

   insert into pres_and_ref(
          id
         ,p_and_r
   )
   values (
          mh_id
         ,prescriptions_and_refills
   );
   set previous_id = mh_id;

-- Case when the id of the next record fetched in the cursor, is equal to the
-- previous record's id. We will only update the record in this case   
elseif previous_id = mh_id then

   set prescriptions_and_refills = concat(d_name, ' (', d_refills, '), ', prescriptions_and_refills);
   update pres_and_ref 
      set p_and_r = prescriptions_and_refills
    where id = previous_id;
    
else
-- Case when we have fetch a record where the id differs from the last inserted record
-- We will insert a new record in this case
   set prescriptions_and_refills = '';
   set prescriptions_and_refills = concat(d_name, ' (', d_refills, '), ', prescriptions_and_refills);

   insert into pres_and_ref(
          id
         ,p_and_r
   )
   values (
          mh_id
         ,prescriptions_and_refills
   );
   set previous_id = mh_id;
end if;

end loop get_drug;
close drugs_cursor;

set p_doctor_lname = nullif(p_doctor_lname, 'NULL');
set p_start_date = nullif(p_start_date, '0000-00-00 00:00:00');
set p_end_date = nullif(p_end_date, '0000-00-00 00:00:00');

	/* query on a specific doctor and date */
	if (p_doctor_lname is not null) and (p_start_date is not null and p_end_date is not null) and (p_patient_id is not null) then
 
  set p_doctor_lname = concat('%', p_doctor_lname, '%');
  
		select mh.Appointment_date
        ,concat(p.First_name, ' ', p.Last_name) as Patient
        ,concat(e.First_name, ' ', e.Last_name) as Doctor
        ,e.Speciality        
        ,mh.Reason_for_appt
        ,pr.p_and_r
        ,mh.Comments
        ,case when mh.Family_dr_flag = 'Y'
              then 'Yes'
              else 'No'
          end as Family_dr_flag
        ,case when mh.Walkin_flag = 'Y'
              then 'Yes'
              else 'No'
          end as Walkin_flag
        ,mh.Revision_date
    from Patient as p 
         inner join Medical_History as mh
                 on p.ID = mh.Patient_ID
         inner join pres_and_ref as pr
                 on mh.ID = pr.id
         inner join Employee as e
                 on mh.Doctor_id = e.Doctor_id
   where mh.Doctor_id in (select Doctor_id
                           from Employee
                          where Last_name like p_doctor_lname
                            and Employee_type = 'DOCTOR') 
     and mh.Appointment_date between p_start_date and p_end_date
     and mh.Patient_id = p_patient_id;

	/* query on all history of a patient for a specific date */
	elseif (p_doctor_lname is null) and (p_start_date is not null and p_end_date is not null) and (p_patient_id is not null) then
 
			select mh.Appointment_date
         ,concat(p.First_name, ' ', p.Last_name) as Patient
         ,concat(e.First_name, ' ', e.Last_name) as Doctor
         ,e.Speciality        
         ,mh.Reason_for_appt
         ,pr.p_and_r
         ,mh.Comments
         ,case when mh.Family_dr_flag = 'Y'
               then 'Yes'
               else 'No'
           end as Family_dr_flag
         ,case when mh.Walkin_flag = 'Y'
               then 'Yes'
               else 'No'
           end as Walkin_flag
         ,mh.Revision_date
     from Patient as p 
          inner join Medical_History as mh
                  on p.ID = mh.Patient_ID
          inner join pres_and_ref as pr
                  on mh.ID = pr.id
          inner join Employee as e
                  on mh.Doctor_id = e.Doctor_id
    where mh.Appointment_date between p_start_date and p_end_date
      and mh.Patient_id = p_patient_id;

	/* query on patient's history with a doctor at a non specific date */
	elseif (p_doctor_lname is not null) and (p_start_date is null and p_end_date is null) and (p_patient_id is not null) then

  set p_doctor_lname = concat('%', p_doctor_lname, '%');
  
		select mh.Appointment_date
        ,concat(p.First_name, ' ', p.Last_name) as Patient
        ,concat(e.First_name, ' ', e.Last_name) as Doctor
        ,e.Speciality        
        ,mh.Reason_for_appt
        ,pr.p_and_r
        ,mh.Comments
        ,case when mh.Family_dr_flag = 'Y'
              then 'Yes'
              else 'No'
          end as Family_dr_flag
        ,case when mh.Walkin_flag = 'Y'
              then 'Yes'
              else 'No'
          end as Walkin_flag
        ,mh.Revision_date
    from Patient as p 
         inner join Medical_History as mh
                 on p.ID = mh.Patient_ID
         inner join pres_and_ref as pr
                 on mh.ID = pr.id
         inner join Employee as e
                 on mh.Doctor_id = e.Doctor_id
   where mh.Doctor_id in (select Doctor_id
                           from Employee
                          where Last_name like p_doctor_lname
                            and Employee_type = 'DOCTOR')                          
     and mh.Patient_id = p_patient_id
   order by mh.Appointment_date desc;

	/* query on a all of patient's medical history */
	elseif (p_doctor_lname is null) and (p_start_date is null and p_end_date is null) and (p_patient_id is not null) then
		
  select mh.Appointment_date
        ,concat(p.First_name, ' ', p.Last_name) as Patient
        ,concat(e.First_name, ' ', e.Last_name) as Doctor
        ,e.Speciality        
        ,mh.Reason_for_appt
        ,pr.p_and_r
        ,mh.Comments
        ,case when mh.Family_dr_flag = 'Y'
              then 'Yes'
              else 'No'
          end as Family_dr_flag
        ,case when mh.Walkin_flag = 'Y'
              then 'Yes'
              else 'No'
          end as Walkin_flag
        ,mh.Revision_date
    from Patient as p 
         inner join Medical_History as mh
                 on p.ID = mh.Patient_ID
         inner join pres_and_ref as pr
                 on mh.ID = pr.id
         inner join Employee as e
                 on mh.Doctor_id = e.Doctor_id
   where mh.Patient_id = p_patient_id
   order by mh.Appointment_date desc;
   
	end if;

end go
delimiter ;

