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

