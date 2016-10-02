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

