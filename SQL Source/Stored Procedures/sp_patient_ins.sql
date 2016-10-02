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

