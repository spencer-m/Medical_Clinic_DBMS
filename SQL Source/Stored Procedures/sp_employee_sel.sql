use HealthcareClinic;
drop procedure if exists sp_employee_sel;
delimiter \\
create procedure sp_employee_sel(
       in p_Employee_id   int
      ,in p_Employee_type varchar(30)
      ,in p_First_name    varchar(50)
      ,in p_Last_name     varchar(50)
      ,in p_Active_flag   varchar(1)
      ,in p_Doctor_id     int
      ,in p_Speciality    varchar(50)
      ,in p_Certification varchar(50)
)
begin
set p_Employee_id = nullif(p_Employee_id, -1);
set p_Employee_type = nullif(p_Employee_type, '');
set p_First_name = nullif(p_First_name, '');
set p_Last_name = nullif(p_Last_name, '');
set p_Active_flag = nullif(p_Active_flag, '');
set p_Doctor_id = nullif(p_Doctor_id, -1);
set p_Speciality = nullif(p_Speciality, '');
set p_Certification = nullif(p_Certification, '');

if (p_Active_flag = 'Yes') then
   set p_Active_flag = 'Y';
end if;

if (p_Active_flag = 'No') then
   set p_Active_flag = 'N';
end if;

if (p_Employee_id is null
    and p_Employee_type is null 
    and p_First_name is null
    and p_Last_name is null
    and p_Active_flag is null
    and p_Doctor_id is null
    and p_Speciality is null
    and p_Certification is null) then
    select e.Employee_id
          ,Employee_type
          ,First_name
          ,Last_name
          ,Gender
          ,SIN_number
          ,Start_date
          ,case when End_date is null
                then 'N/A'
                else End_date
            end as End_date
          ,case when Active_flag = 'Y'
                         then 'Yes'
                         else 'No'
                     end as Active
          ,Phone_number
          ,Address
          ,case when Doctor_id is null
                then 'N/A'
                else Doctor_id
            end as Doctor_id
          ,case when Speciality is null
                then 'N/A'
                else Speciality
            end as Speciality
          ,case when Certification is null
                then 'N/A'
                else Certification
            end as Certification
          ,case when Work_station_number is null
                then 'N/A'
                else Work_station_number
            end as Work_station_number
          ,Revision_user
          ,Revision_date
      from Employee as e;

elseif (p_Employee_id is not null)
   and (p_Employee_type is null 
        and p_First_name is null
        and p_Last_name is null
        and p_Active_flag is null
        and p_Doctor_id is null
        and p_Speciality is null
        and p_Certification is null) then
    select e.Employee_id
          ,Employee_type
          ,First_name
          ,Last_name
          ,Gender
          ,SIN_number
          ,Start_date
          ,case when End_date is null
                then 'N/A'
                else End_date
            end as End_date
          ,case when Active_flag = 'Y'
                         then 'Yes'
                         else 'No'
                     end as Active
          ,Phone_number
          ,Address
          ,case when Doctor_id is null
                then 'N/A'
                else Doctor_id
            end as Doctor_id
          ,case when Speciality is null
                then 'N/A'
                else Speciality
            end as Speciality
          ,case when Certification is null
                then 'N/A'
                else Certification
            end as Certification
          ,case when Work_station_number is null
                then 'N/A'
                else Work_station_number
            end as Work_station_number
          ,Revision_user
          ,Revision_date
      from Employee as e
     where e.Employee_id = p_Employee_id;
     
elseif (p_Employee_type is not null)
         and (p_Employee_id is null 
              and p_First_name is null
              and p_Last_name is null
              and p_Active_flag is null
              and p_Doctor_id is null
              and p_Speciality is null
              and p_Certification is null) then
    select e.Employee_id
          ,Employee_type
          ,First_name
          ,Last_name
          ,Gender
          ,SIN_number
          ,Start_date
          ,case when End_date is null
                then 'N/A'
                else End_date
            end as End_date
          ,case when Active_flag = 'Y'
                         then 'Yes'
                         else 'No'
                     end as Active
          ,Phone_number
          ,Address
          ,case when Doctor_id is null
                then 'N/A'
                else Doctor_id
            end as Doctor_id
          ,case when Speciality is null
                then 'N/A'
                else Speciality
            end as Speciality
          ,case when Certification is null
                then 'N/A'
                else Certification
            end as Certification
          ,case when Work_station_number is null
                then 'N/A'
                else Work_station_number
            end as Work_station_number
          ,Revision_user
          ,Revision_date
      from Employee as e
     where e.Employee_type = p_Employee_type;
 
elseif (p_Doctor_id is not null)
         and (p_Employee_id is null 
              and p_First_name is null
              and p_Last_name is null
              and p_Active_flag is null
              and p_Employee_type is null
              and p_Speciality is null
              and p_Certification is null) then
      select e.Employee_id
            ,Employee_type
            ,First_name
            ,Last_name
            ,Gender
            ,SIN_number
            ,Start_date
            ,case when End_date is null
                  then 'N/A'
                  else End_date
              end as End_date
            ,case when Active_flag = 'Y'
                           then 'Yes'
                           else 'No'
                       end as Active
            ,Phone_number
            ,Address
            ,case when Doctor_id is null
                  then 'N/A'
                  else Doctor_id
              end as Doctor_id
            ,case when Speciality is null
                  then 'N/A'
                  else Speciality
              end as Speciality
            ,case when Certification is null
                  then 'N/A'
                  else Certification
              end as Certification
            ,case when Work_station_number is null
                  then 'N/A'
                  else Work_station_number
              end as Work_station_number
            ,Revision_user
            ,Revision_date
        from Employee as e
       where e.Doctor_id = p_Doctor_id;

elseif (p_Active_flag is not null)
         and (p_Employee_id is null 
              and p_First_name is null
              and p_Last_name is null
              and p_Doctor_id is null
              and p_Employee_type is null
              and p_Speciality is null
              and p_Certification is null) then
       select e.Employee_id
             ,Employee_type
             ,First_name
             ,Last_name
             ,Gender
             ,SIN_number
             ,Start_date
             ,case when End_date is null
                   then 'N/A'
                   else End_date
               end as End_date
             ,case when Active_flag = 'Y'
                            then 'Yes'
                            else 'No'
                        end as Active
             ,Phone_number
             ,Address
             ,case when Doctor_id is null
                   then 'N/A'
                   else Doctor_id
               end as Doctor_id
             ,case when Speciality is null
                   then 'N/A'
                   else Speciality
               end as Speciality
             ,case when Certification is null
                   then 'N/A'
                   else Certification
               end as Certification
             ,case when Work_station_number is null
                   then 'N/A'
                   else Work_station_number
               end as Work_station_number
             ,Revision_user
             ,Revision_date
         from Employee as e
        where e.Active_flag = p_Active_flag;
 
elseif (p_Speciality is not null)
         and (p_Employee_id is null 
              and p_First_name is null
              and p_Last_name is null
              and p_Doctor_id is null
              and p_Employee_type is null
              and p_Active_flag is null
              and p_Certification is null) then
       select e.Employee_id
             ,Employee_type
             ,First_name
             ,Last_name
             ,Gender
             ,SIN_number
             ,Start_date
             ,case when End_date is null
                   then 'N/A'
                   else End_date
               end as End_date
             ,case when Active_flag = 'Y'
                            then 'Yes'
                            else 'No'
                        end as Active
             ,Phone_number
             ,Address
             ,case when Doctor_id is null
                   then 'N/A'
                   else Doctor_id
               end as Doctor_id
             ,case when Speciality is null
                   then 'N/A'
                   else Speciality
               end as Speciality
             ,case when Certification is null
                   then 'N/A'
                   else Certification
               end as Certification
             ,case when Work_station_number is null
                   then 'N/A'
                   else Work_station_number
               end as Work_station_number
             ,Revision_user
             ,Revision_date
         from Employee as e
        where e.Speciality = p_Speciality;
        
elseif (p_Certification is not null)
         and (p_Employee_id is null 
              and p_First_name is null
              and p_Last_name is null
              and p_Doctor_id is null
              and p_Employee_type is null
              and p_Speciality is null
              and p_Active_flag is null) then
       select e.Employee_id
             ,Employee_type
             ,First_name
             ,Last_name
             ,Gender
             ,SIN_number
             ,Start_date
             ,case when End_date is null
                   then 'N/A'
                   else End_date
               end as End_date
             ,case when Active_flag = 'Y'
                            then 'Yes'
                            else 'No'
                        end as Active
             ,Phone_number
             ,Address
             ,case when Doctor_id is null
                   then 'N/A'
                   else Doctor_id
               end as Doctor_id
             ,case when Speciality is null
                   then 'N/A'
                   else Speciality
               end as Speciality
             ,case when Certification is null
                   then 'N/A'
                   else Certification
               end as Certification
             ,case when Work_station_number is null
                   then 'N/A'
                   else Work_station_number
               end as Work_station_number
             ,Revision_user
             ,Revision_date
         from Employee as e
        where e.Certification = p_Certification;

elseif (p_First_name is not null
        and p_Last_name is not null)
            and (p_Doctor_id is null
                 and p_Employee_type is null
                 and p_Employee_id is null
                 and p_Active_flag is null
                 and p_Speciality is null
                 and p_Certification is null) then 
       select e.Employee_id
             ,Employee_type
             ,First_name
             ,Last_name
             ,Gender
             ,SIN_number
             ,Start_date
             ,case when End_date is null
                   then 'N/A'
                   else End_date
               end as End_date
             ,case when Active_flag = 'Y'
                            then 'Yes'
                            else 'No'
                        end as Active
             ,Phone_number
             ,Address
             ,case when Doctor_id is null
                   then 'N/A'
                   else Doctor_id
               end as Doctor_id
             ,case when Speciality is null
                   then 'N/A'
                   else Speciality
               end as Speciality
             ,case when Certification is null
                   then 'N/A'
                   else Certification
               end as Certification
             ,case when Work_station_number is null
                   then 'N/A'
                   else Work_station_number
               end as Work_station_number
             ,Revision_user
             ,Revision_date
         from Employee as e
        where e.First_name = p_First_name
          and e.Last_name = p_Last_name;

elseif (p_First_name is not null
        and p_Last_name is null)
            and (p_Doctor_id is null
                 and p_Employee_type is null
                 and p_Employee_id is null
                 and p_Active_flag is null
                 and p_Speciality is null
                 and p_Certification is null) then
       
       set p_First_name = concat('%', p_First_name, '%');
       select e.Employee_id
             ,Employee_type
             ,First_name
             ,Last_name
             ,Gender
             ,SIN_number
             ,Start_date
             ,case when End_date is null
                   then 'N/A'
                   else End_date
               end as End_date
             ,case when Active_flag = 'Y'
                            then 'Yes'
                            else 'No'
                        end as Active
             ,Phone_number
             ,Address
             ,case when Doctor_id is null
                   then 'N/A'
                   else Doctor_id
               end as Doctor_id
             ,case when Speciality is null
                   then 'N/A'
                   else Speciality
               end as Speciality
             ,case when Certification is null
                   then 'N/A'
                   else Certification
               end as Certification
             ,case when Work_station_number is null
                   then 'N/A'
                   else Work_station_number
               end as Work_station_number
             ,Revision_user
             ,Revision_date
         from Employee as e
        where e.First_name like p_First_name;

elseif (p_First_name is null
        and p_Last_name is not null)
            and (p_Doctor_id is null
                 and p_Employee_type is null
                 and p_Employee_id is null
                 and p_Active_flag is null
                 and p_Speciality is null
                 and p_Certification is null) then 
       
       set p_Last_name = concat('%', p_Last_name, '%');
       
       select e.Employee_id
             ,Employee_type
             ,First_name
             ,Last_name
             ,Gender
             ,SIN_number
             ,Start_date
             ,case when End_date is null
                   then 'N/A'
                   else End_date
               end as End_date
             ,case when Active_flag = 'Y'
                            then 'Yes'
                            else 'No'
                        end as Active
             ,Phone_number
             ,Address
             ,case when Doctor_id is null
                   then 'N/A'
                   else Doctor_id
               end as Doctor_id
             ,case when Speciality is null
                   then 'N/A'
                   else Speciality
               end as Speciality
             ,case when Certification is null
                   then 'N/A'
                   else Certification
               end as Certification
             ,case when Work_station_number is null
                   then 'N/A'
                   else Work_station_number
               end as Work_station_number
             ,Revision_user
             ,Revision_date
         from Employee as e
        where e.Last_name like p_Last_name;

end if;

end \\
delimiter ;

