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

