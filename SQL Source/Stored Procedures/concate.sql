use HealthcareClinic;
drop procedure if exists sp_appointment_del;

delimiter go
create procedure sp_appointment_del(
       in p_Patient_id  int
      ,in p_Date          datetime
)
begin

    delete from Appointment
     where Patient_id = p_Patient_id
       and Date = p_Date;

end go
delimiter ;

use HealthcareClinic;
drop procedure if exists sp_appointment_ins;

delimiter go
create procedure sp_appointment_ins(
       in Date          datetime
      ,in Patient_id       int
      ,in Employee_id      int
      ,in Doctor_id        int
      ,in Family_dr_flag   varchar(1)
      ,in Reason           varchar(2000)
      ,in Walkin_flag      varchar(1)
)
begin

    insert into Appointment(
           Date
          ,Patient_id
          ,Employee_id
          ,Doctor_id
          ,Family_dr_flag
          ,Reason
          ,Walkin_flag
          ,Revision_user
          ,Revision_date
    )
    values(
           Date
          ,Patient_id
          ,Employee_id
          ,Doctor_id
          ,Family_dr_flag
          ,Reason
          ,Walkin_flag
          ,user()
          ,now()
    );

end go
delimiter ;

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

use HealthcareClinic;
drop procedure if exists sp_appointment_sel_all_empl;

delimiter go
create procedure sp_appointment_sel_all_empl(
       in beginTime datetime,
       in endTime datetime
)
begin

    select w.Start_time, w.End_time, e.First_name, e.Last_name
      from scheduled_for as s
		inner join work_day as w
        inner join employee as e
     where s.Work_day_date BETWEEN beginTime AND endTime
     and w.Date = s.Work_day_date
     and s.Employee_id = e.Employee_id;

end go
delimiter ;

use HealthcareClinic;
drop procedure if exists sp_appointment_sel_cal;

delimiter go
create procedure sp_appointment_sel_cal(
       in beginTime datetime,
       in endTime datetime,
       in did int
)
begin

    select *
      from Appointment as a
     where a.date BETWEEN beginTime AND endTime
     and a.Doctor_id = did;

end go
delimiter ;

use HealthcareClinic;
drop procedure if exists sp_appointment_sel_empl;

delimiter go
create procedure sp_appointment_sel_empl(
       in beginTime datetime,
       in endTime datetime,
       in eid int
)
begin

    select w.Start_time, w.End_time, e.First_name, e.Last_name
      from scheduled_for as s
		inner join work_day as w
        inner join employee as e
     where s.Work_day_date BETWEEN beginTime AND endTime
     and s.Employee_id = eid 
     and w.Date = s.Work_day_date
     and eid = e.Employee_id;

end go
delimiter ;

/*
Procedure: select and view the bill(s) for a certain patient
*/
use HealthcareClinic;
drop procedure if exists sp_billing_sel;

delimiter go
create procedure sp_billing_sel(
	in	b_id	int
	,in b_flag	int
)
begin

	set b_id = nullif(b_id, '');
	set b_flag = nullif(b_flag, '');
	
	/* returns a specific invoice */
	if (b_flag is null) and (b_id is not null) then
		select  p.First_name
					,p.Last_name
					,b.Invoice_number
					,b.Amount
					,b.Balance
					,b.Paid
					,a.Date
					,b.Revision_date
		from Billing as b
				 inner join Appointment as a
					on b.Invoice_number = a.Invoice_number
				inner join Patient as p
					on a.Patient_id = p.Id
		where b.Invoice_number = b_id;

	/* returns the incompletely paid invoices */
	elseif (b_flag = 6) and (b_id is null) then
		select  p.First_name
					,p.Last_name
					,b.Invoice_number
					,b.Amount
					,b.Balance
					,b.Paid
					,a.Date
					,b.Revision_date
		from Billing as b
				 inner join Appointment as a
					on b.Invoice_number = a.Invoice_number
				inner join Patient as p
					on a.Patient_id = p.Id
		where b.Balance != 0;

	/* returns the completely paid invoices */
	elseif (b_flag = 4) and (b_id is null) then
		select  p.First_name
					,p.Last_name
					,b.Invoice_number
					,b.Amount
					,b.Balance
					,b.Paid
					,a.Date
					,b.Revision_date
		from Billing as b
				 inner join Appointment as a
					on b.Invoice_number = a.Invoice_number
				inner join Patient as p
					on a.Patient_id = p.Id
		where b.Balance = 0;

	end if;

end go
delimiter ;

/*
Procedure: select and view the bill(s) for a certain patient
*/
use HealthcareClinic;
drop procedure if exists sp_billing_upd;

delimiter go
create procedure sp_billing_upd(
	 in	b_id	int
	,in	b_paid_add	decimal(15,2)
)
begin

update Billing as b
			set   b.Paid = (b.Paid + b_paid_add)
					,b.Balance = (b.Balance - b_paid_add)
					,b.Revision_user = user()
					,b.Revision_date = now()
			where b.Invoice_number = b_id;
end go
delimiter ;

use HealthcareClinic;
drop procedure if exists sp_check_days;

delimiter go
create procedure sp_check_days(
		in startDate datetime,
        in endDate datetime,
        in eid int(11)
)



begin
	declare currhour, endhour datetime;


	DROP TABLE IF EXISTS days;
	CREATE TEMPORARY TABLE days(
	       day datetime
	);
    
    
    
    set currHour = startDate;
	set endhour = endDate;

REPEAT

	insert into days(
    day
    )
    values (
    currHour
    );
    

Set currHour = DATE_ADD(currHour,INTERVAL 24 HOUR);
UNTIL currHour > endhour END REPEAT;

	select *
    from days
    where  
    not exists (select *
				from scheduled_for
                where days.day = scheduled_for.Work_day_date
                and scheduled_for.Employee_id = eid
                );
                
end go
delimiter ;

use HealthcareClinic;
drop procedure if exists sp_clinic_user_del;

delimiter go
create procedure sp_clinic_user_del(
       in p_User_id  int
)
begin

    delete from Clinic_user
     where User_id = p_User_id;
    
end go
delimiter ;

use HealthcareClinic;
drop procedure if exists sp_clinic_user_ins;

delimiter go
create procedure sp_clinic_user_ins(
       in Username        varchar(30)
      ,in Password        varchar(200)
      ,in User_email      varchar(45)
      ,in Date_registered bigint(20)
      ,in Patient_id      int
      ,in Employee_id     int
      ,in User_type       varchar(10)
      ,in Access_rule_id  int
) 
begin

    insert into Clinic_user(
           Username
          ,Password
          ,User_email
          ,Date_registered
          ,Patient_id
          ,Employee_id
          ,User_type
          ,Access_rule_id
          ,Revision_user
          ,Revision_date
    )
    values(
           Username
          ,Password
          ,User_email
          ,Date_registered
          ,Patient_id
          ,Employee_id
          ,User_type
          ,Access_rule_id
          ,user()
          ,now()
    );
                                 
end go
delimiter ;

use HealthcareClinic;
drop procedure if exists sp_clinic_user_sel;

delimiter go
create procedure sp_clinic_user_sel(
       in p_User_id  int
)
begin

    if p_User_id is null then
       select Username
             ,Patient_name = p.First_name + p.Last_name
             ,Employee_name = e.First_name + e.Last_name
             ,e.Employee_type
         from Clinic_user as c
              inner join Patient as p
                      on c.Patient_id = p.ID
              inner join Employee as e
                      on c.Employee_id = e.Employee_id;
     else
        select Username
              ,Patient_name = p.First_name + p.Last_name
              ,Employee_name = e.First_name + e.Last_name
              ,e.Employee_type
          from Clinic_user as c
               inner join Patient as p
                       on c.Patient_id = p.ID
               inner join Employee as e
                       on c.Employee_id = e.Employee_id
         where c.User_id = p_User_id;
     end if;
    
end go
delimiter ;

use HealthcareClinic;
drop procedure if exists sp_clinic_user_upd;

delimiter go
create procedure sp_clinic_user_upd(
       in p_User_id    int
      ,in p_Username        varchar(30)
      ,in p_User_type       varchar(10)
      ,in p_Access_rule_id  int
)
begin

    update Clinic_user
       set Username = p_Username
          ,User_type = p_User_type
          ,Access_rule_id = p_Access_rule_id
     where User_id = p_User_id;

end go
delimiter ;

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

/*
Procedure: Delete a drug entry using DIN
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_drugs_del;

delimiter go
create procedure sp_doctor_drugs_del (
		in	d_id	int
)
begin

	delete from Drugs_Available
			where Drugs_Available.Drug_ID = d_id;


end go
delimiter ;

/*
Procedure: Insert drug entry
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_drugs_ins;

delimiter go
create procedure sp_doctor_drugs_ins (
	 in d_DIN	int
	,in d_name	varchar(100)
	,in d_type	varchar(30)
)
begin

	insert into Drugs_Available (
						 DIN
						,Name
						,Type
						,Revision_user
						,Revision_date
	)
	values (
					 d_DIN
					,d_name
					,d_type
					,user()
					,now()
	);


end go
delimiter ;

/*
Procedure: View drug attributes
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_drugs_sel;

delimiter go
create procedure sp_doctor_drugs_sel (
	 in d_id	int
	,in d_name	varchar(100)
)
begin

	set d_id = nullif(d_id, '');
	set d_name = nullif(d_name, '');

	if (d_id is null) and (d_name  is null) then
		select  d.Name
					,d.Type
					,d.Drug_id
     ,d.DIN
			from Drugs_Available as d
			order by Name;

	elseif (d_id is not null) and (d_name is null) then
		select  d.Name
					,d.Type
					,d.Drug_id
     ,d.DIN
			from Drugs_Available as d
			where d.Drug_ID = d_id;

	elseif (d_id is null) and (d_name  is not null) then
		select  d.Name
					,d.Type
					,d.Drug_id
     ,d.DIN
			from Drugs_Available as d
			where d.Name = d_name;

	elseif (d_id is not null) and (d_name  is not null) then
		select  d.Name
					,d.Type
					,d.Drug_id
     ,d.DIN
			from Drugs_Available as d
			where d.Name = d_name
				and d.Drug_ID = d_id;

	end if;

end go
delimiter ;

/*
Procedure: Update drug entry
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_drugs_upd;

delimiter go
create procedure sp_doctor_drugs_upd (
	 in d_id	int
	,in d_new_name	varchar(100)
	,in d_new_type varchar(30)
)
begin

	set d_new_name = nullif(d_new_name, '');
	set d_new_type = nullif(d_new_type, '');

	if (d_new_name is not null) and (d_new_type is not null) then
		update Drugs_Available as d
				set   d.Name = d_new_name
						,d.Type = d_new_type
						,d.Revision_user = user()
						,d.Revision_date = now()
				where d.Drug_id = d_id;

	elseif (d_new_name is not null) and (d_new_type is null) then
		update Drugs_Available as d
				set   d.Name = d_new_name
						,d.Revision_user = user()
						,d.Revision_date = now()
				where d.Drug_id = d_id;

	elseif (d_new_name is null) and (d_new_type is not null) then
		update Drugs_Available as d
				set    d.Type = d_new_type
						,d.Revision_user = user()
						,d.Revision_date = now()
				where d.Drug_id = d_id;

	end if;

end go
delimiter ;

/*
Procedure: Delete an equipment entry
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_equipment_del;

delimiter go
create procedure sp_doctor_equipment_del (
	 in e_id	int
)
begin

	delete e
		from Equipment as e join Room_Equipment_Xref as rex
			on e.Equipment_ID = rex.Equipment_ID
		where e.Equipment_ID = e_id;

end go
delimiter ;

/*
Procedure: Insert an equipment entry
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_equipment_ins;

delimiter go
create procedure sp_doctor_equipment_ins (
	 in e_name	varchar(50)
	,in e_manufacturer	varchar(250)
	,in e_room_number	int
)
begin

	set @e_user = user();
	set @e_date = now();

	insert into Equipment (
		 Equipment_ID
		,Name
		,Manufacturer
		,Revision_user
		,Revision_date
	)
	value (
		 null
		,e_name
		,e_manufacturer
		,@e_user
		,@e_date
	);

	insert into Room_Equipment_Xref (
		 Room_number
		,Equipment_ID
		,Revision_user
		,Revision_date
	)
	value (
		 e_room_number
		,LAST_INSERT_ID()
		,@e_user
		,@e_date
	);

end go
delimiter ;

/*
Procedure: Get all the equipment grouped by room number, or get all the equipment in a given room or get all the room number of a given equipment.
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_equipment_sel;

delimiter go
create procedure sp_doctor_equipment_sel (
	 in e_name	varchar(50) 
	,in e_room_number	int
	,in e_group_flag	varchar(1)
	,in e_id	int
)
begin

	set e_name = nullif(e_name, '');
	set e_room_number = nullif(e_room_number, '');
	set e_group_flag = nullif(e_group_flag, '' or '0');
	set e_id = nullif(e_id, '');

	/*  returns all the equipment grouped by room number */
	if (e_room_number is null) and (e_name is null) and (e_group_flag is not null) and (e_id is null) then
		select Room_number
        ,COUNT(Name) as Number_of_eqp
        ,Name
        ,Manufacturer
			 from Equipment as e 
         inner join Room_Equipment_Xref as rex
				             on e.Equipment_ID = rex.Equipment_ID
			group by Room_number, Name, Manufacturer;

	/*  returns all the equipment in a given room */
	elseif (e_room_number is not null) and (e_name is null) and (e_group_flag is not null) and (e_id is null) then
		select Room_number
        ,COUNT(Name) as Number_of_eqp 
        ,Name
        ,Manufacturer
			 from Equipment as e 
         inner join Room_Equipment_Xref as rex
				             on e.Equipment_ID = rex.Equipment_ID
			where rex.Room_number = e_room_number
			group by Room_number, Name, Manufacturer;

	/*  returns the room number of a given equipment */
	elseif (e_room_number is null) and (e_name is not null) and (e_group_flag is not null) and (e_id is null) then
		select Room_number
        ,COUNT(Name) as Number_of_eqp
        ,Name
        ,Manufacturer
			 from Equipment as e 
         inner join Room_Equipment_Xref as rex
				             on e.Equipment_ID = rex.Equipment_ID
			where e.Name = e_name
			group by Room_number, Name, Manufacturer;

	/*  returns all the equipment */
	elseif (e_room_number is null) and (e_name is null) and (e_group_flag is null) and (e_id is null) then
		select Room_number
        ,e.Equipment_ID
        ,Name
        ,Manufacturer
			 from Equipment as e 
         inner join Room_Equipment_Xref as rex
				             on e.Equipment_ID = rex.Equipment_ID;

	/*  returns all the equipment in a given room */
	elseif (e_room_number is not null) and (e_name is null) and (e_group_flag is null) and (e_id is null) then
		select Room_number
        ,e.Equipment_ID
        ,Name
        ,Manufacturer
    from Equipment as e 
         inner join Room_Equipment_Xref as rex
                 on e.Equipment_ID = rex.Equipment_ID
			where rex.Room_number = e_room_number;

	/*  returns the room number of a given equipment */
	elseif (e_room_number is null) and (e_name is not null) and (e_group_flag is null) and (e_id is null) then 
		select Room_number
        ,e.Equipment_ID
        ,Name
        ,Manufacturer
			 from Equipment as e 
         inner join Room_Equipment_Xref as rex
				             on e.Equipment_ID = rex.Equipment_ID
			where e.Name = e_name;

	/*  returns the equipment by ID */
	elseif (e_room_number is null) and (e_name is null) and (e_group_flag is null) and (e_id is not null) then 
		select Room_number
        ,e.Equipment_ID
        ,Name
        ,Manufacturer
			 from Equipment as e 
         inner join Room_Equipment_Xref as rex
				             on e.Equipment_ID = rex.Equipment_ID
			where e.Equipment_ID = e_id;

	end if;

end go
delimiter ;

/*
Procedure: Update an equipment entry
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_equipment_upd;

delimiter go
create procedure sp_doctor_equipment_upd (
	 in e_id	int
	,in e_new_name	varchar(50)
	,in e_new_manufacturer	varchar(250)
	,in e_new_room_number	int
)

begin

	set @e_name = (select Name
			from Equipment as e join Room_Equipment_Xref as rex
				on e.Equipment_ID = rex.Equipment_ID
			where e.Equipment_ID = e_id);

	set @e_manufacturer = (select Manufacturer
			from Equipment as e join Room_Equipment_Xref as rex
				on e.Equipment_ID = rex.Equipment_ID
			where e.Equipment_ID = e_id);

	set @e_room_number = (select Room_number
			from Equipment as e join Room_Equipment_Xref as rex
				on e.Equipment_ID = rex.Equipment_ID
			where e.Equipment_ID = e_id);

	if (e_new_name = '' or null) then
		set e_new_name = @e_name;
	end if;
	if (e_new_manufacturer = '' or null) then
		set e_new_manufacturer = @e_manufacturer;
	end if;
	if (e_new_room_number = '' or null) then
		set e_new_room_number = @e_room_number;
	end if;
	
	set @e_user = user();
	set @e_date = now();

	update Equipment as e join Room_Equipment_Xref as rex
			on e.Equipment_ID = rex.Equipment_ID
			set   e.Name = e_new_name
					,e.Manufacturer = e_new_manufacturer
					,e.Revision_user = @e_user
					,e.Revision_date = @e_date
					,rex.Room_number = e_new_room_number
					,rex.Revision_user = @e_user
					,rex.Revision_date = @e_date
			where e.Equipment_ID = e_id;

end go
delimiter ;

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

/*
Procedure: Delete a supply table entry for a unique room
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_supplies_del;

delimiter go
create procedure sp_doctor_supplies_del (
	 in s_id	int
	,in s_room_number	int
)
begin

	set s_id = nullif(s_id, '');
	set s_room_number = nullif(s_room_number, -1);

	if (s_id is not null) and (s_room_number is not null) then

		delete rsx
			from Room_Supplies_Xref as rsx
			where rsx.Supplies_id = s_id
				and	rsx.Room_number = s_room_number;

	elseif (s_id is not null) and (s_room_number is null) then

		delete s
			from Supplies as s
			where s.ID = s_id;

	end if;

end go
delimiter ;

/*
Procedure: Insert a supply
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_supplies_ins;

delimiter go
create procedure sp_doctor_supplies_ins (
	 in s_name	varchar(50)
	,in s_supplier	varchar(45)
	,in s_room_number	int
	,in s_amount	int
)
begin
 declare s_user varchar(30);
 declare s_date datetime;
 declare s_id   int;
 declare s_flag int;
 
	set s_user = user();
	set s_date = now();
	
	
	set s_id = (select ID 
								from Supplies as s
								where s.Name = s_name
									and	s.Supplier = s_supplier
								order by ID
								limit 1);
	

	if (s_id is null) then

		insert into Supplies (
     Name
				,Supplier
				,Revision_user
				,Revision_date
		)
		values (
				 s_name
				,s_supplier
				,s_user
				,s_date
		);

		insert into Room_Supplies_Xref (
				 Room_number
				,Supplies_ID
				,Amount
				,Revision_user
				,Revision_date
		)
		values (
				 s_room_number
				,LAST_INSERT_ID()
				,s_amount
				,s_user
				,s_date
		);
	
	else 
	
		set s_flag = exists (select * 
												from Room_Supplies_Xref as rsx
												where rsx.Room_number = s_room_number
													and	rsx.Supplies_id = s_id);
		
		if (s_flag = 1) then
			update  Room_Supplies_Xref
				set	  Amount = Amount + s_amount
				where Supplies_id = s_id;

   select 'hello';
		else

		insert into Room_Supplies_Xref (
				Room_number
				,Supplies_ID
				,Amount
				,Revision_user
				,Revision_date
		)
		values (
				s_room_number
				,s_id
				,s_amount
				,s_user
				,s_date
		);
		end if;

	end if;
	

end go
delimiter ;

/*
Procedure:
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_supplies_sel;

delimiter go
create procedure sp_doctor_supplies_sel (
	 in s_room_number	int
	,in s_supplies_name	varchar(50)
	,in s_group_flag	varchar(1)
)
begin

	set s_supplies_name = nullif(s_supplies_name, '');
	set s_room_number = nullif(s_room_number, '');
	set s_group_flag = nullif(s_group_flag, '' or '0');

	/* returns amount of supplies by room number */
	if (s_room_number is null) and (s_supplies_name is not null)  and (s_group_flag is null) then
		select  ID
					,Room_number
					,Name
					,Supplier
					,Amount
			from Supplies as s join Room_Supplies_Xref as rsx
				on s.ID = rsx.Supplies_ID
			where s.Name = s_supplies_name;

	/* returns all supplies in a given room */
	elseif (s_room_number is not null) and (s_supplies_name is null) and (s_group_flag is null) then
		select	 ID
					,Room_number
					,Name
					,Supplier
					,Amount
			from Supplies as s join Room_Supplies_Xref as rsx
				on s.ID = rsx.Supplies_ID
			where rsx.Room_number = s_room_number;

	/* returns amount of a given supply in a given room */
	elseif (s_room_number is not null) and (s_supplies_name is not null) and (s_group_flag is null) then
		select  ID
					,Room_number
					,Name
					,Supplier
					,Amount
			from Supplies as s join Room_Supplies_Xref as rsx
				on s.ID = rsx.Supplies_ID
			where rsx.Room_number = s_room_number
				and s.Name = s_supplies_name;

	/* returns all the supplies */
	elseif (s_room_number is null) and (s_supplies_name is null) and (s_group_flag is null) then
		select  ID
					,Name
					,Supplier
			from Supplies
			order by ID;

	/* returns all the supplies ordered by room number */
	elseif (s_room_number is null) and (s_supplies_name is null) and (s_group_flag is not null) then
		select  ID
					,Name
					,Supplier
					,Room_number
					,Amount
			from Supplies as s join Room_Supplies_Xref as rsx
				on s.ID = rsx.Supplies_ID
			order by Room_number, Name;

	end if;

end go
delimiter ;

/*
Procedure: Update a supply entry
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_supplies_upd;

delimiter go
create procedure sp_doctor_supplies_upd (
	 in s_id	int
	,in s_room_number	int
	,in s_name	varchar(50)
	,in s_supplier	varchar(45)
	,in s_amount	int
)
begin

	set s_id = nullif(s_id, '');
	set s_room_number = nullif(s_room_number, -1);	
	set s_name = nullif(s_name, '');
	set s_supplier = nullif(s_supplier, '');
	set s_amount = nullif(s_amount, -1);

	if (s_id is not null) and (s_room_number is not null) and (s_name is null) and (s_supplier is null) and (s_amount is not null) then

		update Room_Supplies_Xref as rsx
			set	 rsx.Amount = s_amount
					,rsx.Revision_user = user()
					,rsx.Revision_date = now()
		where rsx.Supplies_ID = s_id
			and rsx.Room_number = s_room_number;

	elseif (s_id is not null) and (s_room_number is null) and (s_name is not null) and (s_supplier is not null) and (s_amount is null) then

		update Supplies as s
			set 	 s.Name = s_name
					,s.Supplier = s_supplier
			where s.ID = s_id;

	end if;

end go
delimiter ;

/*
Procedure: update employee attributes
*/
use HealthcareClinic;
drop procedure if exists sp_employee_upd;

delimiter go
create procedure sp_employee_upd(
                in p_Employee_id         int
               ,in p_First_name          varchar(50)
               ,in p_Last_name           varchar(50)
               ,in p_Gender              varchar(1)
               ,in p_Active_flag         varchar(1)
               ,in p_Phone_number        varchar(15)
               ,in p_Address             varchar(250)
               ,in p_Speciality          varchar(50)
               ,in p_Certification       varchar(50)
               ,in p_Work_station_number int
)
begin
/*start transaction;

    declare `err` bool default 0;
    declare continue handler for sqlexception;
    begin
        rollback;
    end;
*/
set p_Work_station_number = nullif(p_Work_station_number, -1);

    update Employee as e
       set e.First_name = case when p_First_name = ''
                               then e.First_name
                               else p_First_name
                           end                               
          ,e.Last_name = case when p_Last_name = ''
                              then e.Last_name
                              else p_Last_name
                          end
          ,e.Gender = case when p_Gender = ''
                           then e.Gender
                           else p_Gender
                       end
          ,e.End_date = case when p_Active_flag = 'N'
                             then now()
                             else e.End_date
                         end
          ,e.Active_flag = case when p_Active_flag = ''
                                then e.Active_flag
                                else p_Active_flag
                            end                            
          ,e.Phone_number = case when p_Phone_number = ''
                                 then e.Phone_number
                                 else p_Phone_number
                             end
          ,e.Address = case when p_Address = ''
                            then e.Address
                            else p_Address
                        end 
          ,e.Speciality = case when p_Speciality = ''
                               then e.Speciality
                               else p_Speciality
                           end
          ,e.Certification = case when p_Certification = ''  or p_Certification is null
                                  then e.Certification
                                  else p_Certification
                              end
          ,e.Revision_user = user()
          ,e.Revision_date = now()
     where e.Employee_id = p_Employee_id;

     /*commit;*/
end go
delimiter ;

drop procedure if exists sp_employee_del;
delimiter //
create procedure sp_employee_del(
      in `Employee_id` int
)
begin

    delete from Employee
     where Employee_id = Employee_id;

end //
delimiter ;

/*
Procedure: Insert into employee table, a new employee record
*/
drop procedure if exists sp_employee_ins;
delimiter //
create procedure sp_employee_ins (
       in p_Employee_type       varchar(30)
      ,in p_First_name          varchar(50)
      ,in p_Last_name           varchar(50)
      ,in p_Gender              varchar(1)
      ,in p_SIN_number          varchar(15)
      ,in p_Start_date          datetime
      ,in p_Phone_number        varchar(15)
      ,in p_Address             varchar(250)
      ,in p_Doctor_id           int
      ,in p_Speciality          varchar(50)
      ,in p_Certification       varchar(50)
      ,in p_Work_station_number int
      ,in p_Username            varchar(30)
      ,in p_Password            varchar(200)
      ,in p_User_email          varchar(45)
      ,in p_Date_registered     bigint(20)
)
begin
declare ar_id int;

set p_Speciality = nullif(p_Speciality, '');
set p_Certification = nullif(p_Certification, '');
set p_Work_station_number = nullif(p_Work_station_number, -1);
set p_Doctor_id = nullif(p_Doctor_id, -1);
set p_Doctor_id = nullif(p_Employee_type, 'NURSE');
set p_Doctor_id = nullif(p_Doctor_id, 0);

    insert into Employee(
           Employee_type
          ,First_name
          ,Last_name
          ,Gender
          ,SIN_number
          ,Start_date
          ,Active_flag
          ,Phone_number
          ,Address
          ,Doctor_id
          ,Speciality
          ,Certification
          ,Work_station_number
          ,Revision_user
          ,Revision_date
    )
    select p_Employee_type
          ,p_First_name
          ,p_Last_name
          ,p_Gender
          ,p_SIN_number
          ,p_Start_date
          ,'Y'
          ,p_Phone_number
          ,p_Address
          ,p_Doctor_id
          ,case when p_Employee_type <> 'DOCTOR'
                then null 
                else p_Speciality 
            end
          ,case when p_Employee_type <> 'NURSE'
                then null
                else p_Certification
            end
          ,case when p_Employee_type <> 'RECEPTIONIST'
                then null
                else p_Work_station_number
            end
          ,user()
          ,now();

if (p_Employee_type = 'DOCTOR') then

   set ar_id = (select ID
                  from Access_rule
                 where Access_type = 'DOCTOR');
                 
   call sp_clinic_user_ins(p_Username 
                       ,p_Password
                       ,p_User_email
                       ,p_Date_registered
                       ,null
                       ,last_insert_id()
                       ,'DOCTOR'
                       ,ar_id);              
                 
elseif (p_Employee_type = 'NURSE') then

   set ar_id = (select ID
                  from Access_rule
                 where Access_type = 'NURSE');
   call sp_clinic_user_ins(p_Username 
                       ,p_Password
                       ,p_User_email
                       ,p_Date_registered
                       ,null
                       ,last_insert_id()
                       ,'NURSE'
                       ,ar_id);                 
                 
elseif (p_Employee_type = 'RECEPTIONIST') then

   set ar_id = (select ID
                  from Access_rule
                 where Access_type = 'RECEPTION');
                 
   call sp_clinic_user_ins(p_Username 
                       ,p_Password
                       ,p_User_email
                       ,p_Date_registered
                       ,null
                       ,last_insert_id()
                       ,'RECEPTIONIST'
                       ,ar_id);

end if;
 
end //
delimiter ;

use HealthcareClinic;
drop procedure if exists sp_employee_schedule_del;

delimiter go
create procedure sp_employee_schedule_del(
       in p_Employee_id    int
      ,in p_Work_day_date  datetime
)
begin

    delete from Scheduled_For
     where Employee_id = p_Employee_id
       and Work_day_date = p_Work_day_date;

end go
delimiter ;

use HealthcareClinic;
drop procedure if exists sp_employee_schedule_ins;

delimiter go
create procedure sp_employee_schedule_ins (
       in Employee_id      int
      ,in Work_day_date    datetime
      ,in Start_time       datetime
      ,in End_time         datetime
)
begin
    insert into Work_Day(
           Date
          ,Start_time
          ,End_time
          ,Revision_user
          ,Revision_date
    )
    values(
           Work_day_date
          ,Start_time
          ,End_time
          ,user()
          ,now()
    );
    select Work_day_date;
    -- set FOREIGN_KEY_CHECKS = 0;
    insert into Scheduled_for (
           Employee_id
          ,Work_day_date
          ,Revision_user
          ,Revision_date
    )
    values(
           Employee_id
          ,Work_day_date
          ,user()
          ,now()
    );
    -- set FOREIGN_KEY_CHECKS = 1;

end go
delimiter ;

/*
Procedure: update employee attributes
*/
use HealthcareClinic;
drop procedure if exists sp_employee_schedule_sel;

delimiter go
create procedure sp_employee_schedule_sel(
       in Employee_id    int
      ,in Work_day_date  datetime
)
begin

select w.Start_time
      ,w.End_time
  from Employee as e
       inner join Scheduled_for as sf
               on e.Employee_id = sf.Employee_id
       inner join Work_day as w
               on sf.work_day_date = w.date;

end go
delimiter ;

use HealthcareClinic;
drop procedure if exists sp_employee_schedule_upd;

delimiter go
create procedure sp_employee_schedule_upd(
       in Employee_id     int
      ,in Work_day_date   datetime
      ,in New_date        datetime
)
begin

    update Scheduled_For
       set Work_day_date = New_date
     where Employee_id = Employee_id
       and Work_day_date = Work_day_date;

end go
delimiter ;

use HealthcareClinic;
drop procedure if exists sp_employee_sel;
delimiter \\
create procedure sp_employee_sel(
       in p_Employee_id   int
      ,in p_Employee_type varchar(30)
      ,in p_First_name    varchar(50)
      ,in p_Last_name     varchar(50)
      ,in p_Active_flag   varchar(1)
      ,in p_Doctor_id     int
      ,in p_Speciality    varchar(50)
      ,in p_Certification varchar(50)
)
begin
set p_Employee_id = nullif(p_Employee_id, -1);
set p_Employee_type = nullif(p_Employee_type, '');
set p_First_name = nullif(p_First_name, '');
set p_Last_name = nullif(p_Last_name, '');
set p_Active_flag = nullif(p_Active_flag, '');
set p_Doctor_id = nullif(p_Doctor_id, -1);
set p_Speciality = nullif(p_Speciality, '');
set p_Certification = nullif(p_Certification, '');

if (p_Active_flag = 'Yes') then
   set p_Active_flag = 'Y';
end if;

if (p_Active_flag = 'No') then
   set p_Active_flag = 'N';
end if;

if (p_Employee_id is null
    and p_Employee_type is null 
    and p_First_name is null
    and p_Last_name is null
    and p_Active_flag is null
    and p_Doctor_id is null
    and p_Speciality is null
    and p_Certification is null) then
    select e.Employee_id
          ,Employee_type
          ,First_name
          ,Last_name
          ,Gender
          ,SIN_number
          ,Start_date
          ,case when End_date is null
                then 'N/A'
                else End_date
            end as End_date
          ,case when Active_flag = 'Y'
                         then 'Yes'
                         else 'No'
                     end as Active
          ,Phone_number
          ,Address
          ,case when Doctor_id is null
                then 'N/A'
                else Doctor_id
            end as Doctor_id
          ,case when Speciality is null
                then 'N/A'
                else Speciality
            end as Speciality
          ,case when Certification is null
                then 'N/A'
                else Certification
            end as Certification
          ,case when Work_station_number is null
                then 'N/A'
                else Work_station_number
            end as Work_station_number
          ,Revision_user
          ,Revision_date
      from Employee as e;

elseif (p_Employee_id is not null)
   and (p_Employee_type is null 
        and p_First_name is null
        and p_Last_name is null
        and p_Active_flag is null
        and p_Doctor_id is null
        and p_Speciality is null
        and p_Certification is null) then
    select e.Employee_id
          ,Employee_type
          ,First_name
          ,Last_name
          ,Gender
          ,SIN_number
          ,Start_date
          ,case when End_date is null
                then 'N/A'
                else End_date
            end as End_date
          ,case when Active_flag = 'Y'
                         then 'Yes'
                         else 'No'
                     end as Active
          ,Phone_number
          ,Address
          ,case when Doctor_id is null
                then 'N/A'
                else Doctor_id
            end as Doctor_id
          ,case when Speciality is null
                then 'N/A'
                else Speciality
            end as Speciality
          ,case when Certification is null
                then 'N/A'
                else Certification
            end as Certification
          ,case when Work_station_number is null
                then 'N/A'
                else Work_station_number
            end as Work_station_number
          ,Revision_user
          ,Revision_date
      from Employee as e
     where e.Employee_id = p_Employee_id;
     
elseif (p_Employee_type is not null)
         and (p_Employee_id is null 
              and p_First_name is null
              and p_Last_name is null
              and p_Active_flag is null
              and p_Doctor_id is null
              and p_Speciality is null
              and p_Certification is null) then
    select e.Employee_id
          ,Employee_type
          ,First_name
          ,Last_name
          ,Gender
          ,SIN_number
          ,Start_date
          ,case when End_date is null
                then 'N/A'
                else End_date
            end as End_date
          ,case when Active_flag = 'Y'
                         then 'Yes'
                         else 'No'
                     end as Active
          ,Phone_number
          ,Address
          ,case when Doctor_id is null
                then 'N/A'
                else Doctor_id
            end as Doctor_id
          ,case when Speciality is null
                then 'N/A'
                else Speciality
            end as Speciality
          ,case when Certification is null
                then 'N/A'
                else Certification
            end as Certification
          ,case when Work_station_number is null
                then 'N/A'
                else Work_station_number
            end as Work_station_number
          ,Revision_user
          ,Revision_date
      from Employee as e
     where e.Employee_type = p_Employee_type;
 
elseif (p_Doctor_id is not null)
         and (p_Employee_id is null 
              and p_First_name is null
              and p_Last_name is null
              and p_Active_flag is null
              and p_Employee_type is null
              and p_Speciality is null
              and p_Certification is null) then
      select e.Employee_id
            ,Employee_type
            ,First_name
            ,Last_name
            ,Gender
            ,SIN_number
            ,Start_date
            ,case when End_date is null
                  then 'N/A'
                  else End_date
              end as End_date
            ,case when Active_flag = 'Y'
                           then 'Yes'
                           else 'No'
                       end as Active
            ,Phone_number
            ,Address
            ,case when Doctor_id is null
                  then 'N/A'
                  else Doctor_id
              end as Doctor_id
            ,case when Speciality is null
                  then 'N/A'
                  else Speciality
              end as Speciality
            ,case when Certification is null
                  then 'N/A'
                  else Certification
              end as Certification
            ,case when Work_station_number is null
                  then 'N/A'
                  else Work_station_number
              end as Work_station_number
            ,Revision_user
            ,Revision_date
        from Employee as e
       where e.Doctor_id = p_Doctor_id;

elseif (p_Active_flag is not null)
         and (p_Employee_id is null 
              and p_First_name is null
              and p_Last_name is null
              and p_Doctor_id is null
              and p_Employee_type is null
              and p_Speciality is null
              and p_Certification is null) then
       select e.Employee_id
             ,Employee_type
             ,First_name
             ,Last_name
             ,Gender
             ,SIN_number
             ,Start_date
             ,case when End_date is null
                   then 'N/A'
                   else End_date
               end as End_date
             ,case when Active_flag = 'Y'
                            then 'Yes'
                            else 'No'
                        end as Active
             ,Phone_number
             ,Address
             ,case when Doctor_id is null
                   then 'N/A'
                   else Doctor_id
               end as Doctor_id
             ,case when Speciality is null
                   then 'N/A'
                   else Speciality
               end as Speciality
             ,case when Certification is null
                   then 'N/A'
                   else Certification
               end as Certification
             ,case when Work_station_number is null
                   then 'N/A'
                   else Work_station_number
               end as Work_station_number
             ,Revision_user
             ,Revision_date
         from Employee as e
        where e.Active_flag = p_Active_flag;
 
elseif (p_Speciality is not null)
         and (p_Employee_id is null 
              and p_First_name is null
              and p_Last_name is null
              and p_Doctor_id is null
              and p_Employee_type is null
              and p_Active_flag is null
              and p_Certification is null) then
       select e.Employee_id
             ,Employee_type
             ,First_name
             ,Last_name
             ,Gender
             ,SIN_number
             ,Start_date
             ,case when End_date is null
                   then 'N/A'
                   else End_date
               end as End_date
             ,case when Active_flag = 'Y'
                            then 'Yes'
                            else 'No'
                        end as Active
             ,Phone_number
             ,Address
             ,case when Doctor_id is null
                   then 'N/A'
                   else Doctor_id
               end as Doctor_id
             ,case when Speciality is null
                   then 'N/A'
                   else Speciality
               end as Speciality
             ,case when Certification is null
                   then 'N/A'
                   else Certification
               end as Certification
             ,case when Work_station_number is null
                   then 'N/A'
                   else Work_station_number
               end as Work_station_number
             ,Revision_user
             ,Revision_date
         from Employee as e
        where e.Speciality = p_Speciality;
        
elseif (p_Certification is not null)
         and (p_Employee_id is null 
              and p_First_name is null
              and p_Last_name is null
              and p_Doctor_id is null
              and p_Employee_type is null
              and p_Speciality is null
              and p_Active_flag is null) then
       select e.Employee_id
             ,Employee_type
             ,First_name
             ,Last_name
             ,Gender
             ,SIN_number
             ,Start_date
             ,case when End_date is null
                   then 'N/A'
                   else End_date
               end as End_date
             ,case when Active_flag = 'Y'
                            then 'Yes'
                            else 'No'
                        end as Active
             ,Phone_number
             ,Address
             ,case when Doctor_id is null
                   then 'N/A'
                   else Doctor_id
               end as Doctor_id
             ,case when Speciality is null
                   then 'N/A'
                   else Speciality
               end as Speciality
             ,case when Certification is null
                   then 'N/A'
                   else Certification
               end as Certification
             ,case when Work_station_number is null
                   then 'N/A'
                   else Work_station_number
               end as Work_station_number
             ,Revision_user
             ,Revision_date
         from Employee as e
        where e.Certification = p_Certification;

elseif (p_First_name is not null
        and p_Last_name is not null)
            and (p_Doctor_id is null
                 and p_Employee_type is null
                 and p_Employee_id is null
                 and p_Active_flag is null
                 and p_Speciality is null
                 and p_Certification is null) then 
       select e.Employee_id
             ,Employee_type
             ,First_name
             ,Last_name
             ,Gender
             ,SIN_number
             ,Start_date
             ,case when End_date is null
                   then 'N/A'
                   else End_date
               end as End_date
             ,case when Active_flag = 'Y'
                            then 'Yes'
                            else 'No'
                        end as Active
             ,Phone_number
             ,Address
             ,case when Doctor_id is null
                   then 'N/A'
                   else Doctor_id
               end as Doctor_id
             ,case when Speciality is null
                   then 'N/A'
                   else Speciality
               end as Speciality
             ,case when Certification is null
                   then 'N/A'
                   else Certification
               end as Certification
             ,case when Work_station_number is null
                   then 'N/A'
                   else Work_station_number
               end as Work_station_number
             ,Revision_user
             ,Revision_date
         from Employee as e
        where e.First_name = p_First_name
          and e.Last_name = p_Last_name;

elseif (p_First_name is not null
        and p_Last_name is null)
            and (p_Doctor_id is null
                 and p_Employee_type is null
                 and p_Employee_id is null
                 and p_Active_flag is null
                 and p_Speciality is null
                 and p_Certification is null) then
       
       set p_First_name = concat('%', p_First_name, '%');
       select e.Employee_id
             ,Employee_type
             ,First_name
             ,Last_name
             ,Gender
             ,SIN_number
             ,Start_date
             ,case when End_date is null
                   then 'N/A'
                   else End_date
               end as End_date
             ,case when Active_flag = 'Y'
                            then 'Yes'
                            else 'No'
                        end as Active
             ,Phone_number
             ,Address
             ,case when Doctor_id is null
                   then 'N/A'
                   else Doctor_id
               end as Doctor_id
             ,case when Speciality is null
                   then 'N/A'
                   else Speciality
               end as Speciality
             ,case when Certification is null
                   then 'N/A'
                   else Certification
               end as Certification
             ,case when Work_station_number is null
                   then 'N/A'
                   else Work_station_number
               end as Work_station_number
             ,Revision_user
             ,Revision_date
         from Employee as e
        where e.First_name like p_First_name;

elseif (p_First_name is null
        and p_Last_name is not null)
            and (p_Doctor_id is null
                 and p_Employee_type is null
                 and p_Employee_id is null
                 and p_Active_flag is null
                 and p_Speciality is null
                 and p_Certification is null) then 
       
       set p_Last_name = concat('%', p_Last_name, '%');
       
       select e.Employee_id
             ,Employee_type
             ,First_name
             ,Last_name
             ,Gender
             ,SIN_number
             ,Start_date
             ,case when End_date is null
                   then 'N/A'
                   else End_date
               end as End_date
             ,case when Active_flag = 'Y'
                            then 'Yes'
                            else 'No'
                        end as Active
             ,Phone_number
             ,Address
             ,case when Doctor_id is null
                   then 'N/A'
                   else Doctor_id
               end as Doctor_id
             ,case when Speciality is null
                   then 'N/A'
                   else Speciality
               end as Speciality
             ,case when Certification is null
                   then 'N/A'
                   else Certification
               end as Certification
             ,case when Work_station_number is null
                   then 'N/A'
                   else Work_station_number
               end as Work_station_number
             ,Revision_user
             ,Revision_date
         from Employee as e
        where e.Last_name like p_Last_name;

end if;

end \\
delimiter ;

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

/*
Procedure: Insert a new patient into the clinic database
*/
use HealthcareClinic;
drop procedure if exists sp_patient_ins;

delimiter go
create procedure sp_patient_ins(
       in First_name          varchar(50)
      ,in Last_name           varchar(50)
      ,in SIN_number          varchar(15)
      ,in Health_care_number  varchar(15)
      ,in Address             varchar(250)
      ,in Phone_number        varchar(15)
      ,in Allergies           varchar(250)
      ,in Username            varchar(30)
      ,in Password            varchar(200)
      ,in User_email          varchar(45)
      ,in Date_registered     bigint(20)
)
begin
declare ar_id int;
    insert into Patient(
           SIN_number
          ,First_name
          ,Last_name
          ,Allergies
          ,Health_care_number
          ,Address
          ,Phone_number
          ,Revision_user
          ,Revision_date
    )
    values(
           SIN_number
          ,First_name
          ,Last_name
          ,Allergies
          ,Health_care_number
          ,Address
          ,Phone_number
          ,user()
          ,now()
    );
    
set ar_id = (select ID
               from Access_rule
              where Access_type = 'PATIENT');
 
call sp_clinic_user_ins(Username 
                       ,Password
                       ,User_email
                       ,Date_registered
                       ,last_insert_id()
                       ,null
                       ,'PATIENT'
                       ,ar_id);

end go
delimiter ;

/*
Procedure: Insert a new patient into the clinic database
*/
use HealthcareClinic;
drop procedure if exists sp_patient_sel;

delimiter go
create procedure sp_patient_sel(
       in p_First_name          varchar(50)
      ,in p_Last_name           varchar(50)
      ,in p_Health_care_number  varchar(15)
)
begin

set p_First_name = nullif(p_First_name, '');
set p_Last_name = nullif(p_Last_name,'');
set p_Health_care_number = nullif(p_Health_care_number,'');

if (p_First_name is not null)
    and (p_Last_name is not null) then

    select Id
          ,First_name
          ,Last_name
          ,Allergies
          ,Health_care_number
          ,Address
          ,Phone_number
          ,Revision_user
          ,Revision_date
      from Patient
     where First_name = p_First_name
       and Last_name = p_Last_name
     order by Last_name;
elseif (p_Health_care_number is not null)
         and ((p_First_name is null) 
              or (p_Last_name is null)) then 
    
    set p_Health_care_number = concat('%', p_Health_care_number, '%');
    select Id
          ,First_name
          ,Last_name
          ,Allergies
          ,Health_care_number
          ,Address
          ,Phone_number
          ,Revision_user
          ,Revision_date
      from Patient
     where Health_care_number like p_Health_care_number 
     order by Last_name;

elseif (p_Last_name is not null)
         and (p_First_name is null)
         and (p_Health_care_number is null) then
    
    set p_Last_name = concat('%', p_Last_name, '%');
    select Id
          ,First_name
          ,Last_name
          ,Allergies
          ,Health_care_number
          ,Address
          ,Phone_number
          ,Revision_user
          ,Revision_date
      from Patient
     where Last_name like p_Last_name
     order by Last_name;

elseif (p_First_name is not null)
        and (p_Last_name is null)
        and (p_Health_care_number is null) then
        
    set p_First_name = concat('%', p_First_name, '%');    
    select Id
          ,First_name
          ,Last_name
          ,Allergies
          ,Health_care_number
          ,Address
          ,Phone_number
          ,Revision_user
          ,Revision_date
      from Patient
     where First_name like p_First_name
     order by Last_name;
        
else 
    select Id
          ,First_name
          ,Last_name
          ,Allergies
          ,Health_care_number
          ,Address
          ,Phone_number
          ,Revision_user
          ,Revision_date
      from Patient
     order by Last_name;
end if;

end go
delimiter ;

/*
Procedure: Find patient from ID
*/
use HealthcareClinic;
drop procedure if exists sp_patient_sel_ID;

delimiter go
create procedure sp_patient_sel_ID(
       in p_ID          int(11)
)
begin
    select 
          First_name
          ,Last_name
          
      from Patient
     where ID = p_ID;
end go
delimiter ;

/*
Procedure: select and view the bill(s) for a certain patient
*/
use HealthcareClinic;
drop procedure if exists sp_patient_upd;

delimiter go
create procedure sp_patient_upd(
       in p_Patient_id          int
      ,in p_First_name          varchar(50)
      ,in p_Last_name           varchar(50)
      ,in p_Allergies           varchar(250)
      ,in p_Address             varchar(250)
      ,in p_Phone_number        varchar(15)
)
begin

    update Patient as p
       set p.First_name = case when p_First_name = ''
                               then p.First_name
                               else p_First_name
                           end
          ,p.Last_name = case when p_Last_name = ''
                              then p.Last_name
                              else p_Last_name
                          end
          ,p.Allergies = case when p_Allergies = ''
                              then p.Allergies
                              else p_Allergies
                          end
          ,p.Address = case when p_Address = ''
                            then p.Address
                            else p_Address
                        end
          ,p.Phone_number = case when p_Phone_number = ''
                                 then p.Phone_number
                                 else p_Phone_number
                             end
          ,p.Revision_user = user()
          ,p.Revision_date = now()
     where p.ID = p_Patient_id;

end go
delimiter ;

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

use HealthcareClinic;
drop procedure if exists sp_work_day_ins;

delimiter go
create procedure sp_work_day_ins (
       in Date        datetime
      ,in Start_time  datetime
      ,in End_time    datetime
)
begin

    insert into Work_day(
           Date
          ,Start_time
          ,End_time
          ,Revision_user
          ,Revision_date
    )
    values(
           Date
          ,Start_time
          ,End_time
          ,user()
          ,now()
    );
    
end go
delimiter ;

