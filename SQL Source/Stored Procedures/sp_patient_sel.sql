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

