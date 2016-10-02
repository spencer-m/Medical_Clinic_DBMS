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

