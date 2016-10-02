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

