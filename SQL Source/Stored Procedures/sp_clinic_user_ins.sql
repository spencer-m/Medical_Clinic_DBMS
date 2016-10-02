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

