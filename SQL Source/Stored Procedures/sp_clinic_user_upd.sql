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

