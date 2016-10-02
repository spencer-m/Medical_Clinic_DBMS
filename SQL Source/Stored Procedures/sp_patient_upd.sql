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

