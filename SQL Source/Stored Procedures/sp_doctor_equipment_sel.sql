/*
Procedure: Get all the equipment grouped by room number, or get all the equipment in a given room or get all the room number of a given equipment.
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_equipment_sel;

delimiter go
create procedure sp_doctor_equipment_sel (
	 in e_name	varchar(50) 
	,in e_room_number	int
	,in e_group_flag	varchar(1)
	,in e_id	int
)
begin

	set e_name = nullif(e_name, '');
	set e_room_number = nullif(e_room_number, '');
	set e_group_flag = nullif(e_group_flag, '' or '0');
	set e_id = nullif(e_id, '');

	/*  returns all the equipment grouped by room number */
	if (e_room_number is null) and (e_name is null) and (e_group_flag is not null) and (e_id is null) then
		select Room_number
        ,COUNT(Name) as Number_of_eqp
        ,Name
        ,Manufacturer
			 from Equipment as e 
         inner join Room_Equipment_Xref as rex
				             on e.Equipment_ID = rex.Equipment_ID
			group by Room_number, Name, Manufacturer;

	/*  returns all the equipment in a given room */
	elseif (e_room_number is not null) and (e_name is null) and (e_group_flag is not null) and (e_id is null) then
		select Room_number
        ,COUNT(Name) as Number_of_eqp 
        ,Name
        ,Manufacturer
			 from Equipment as e 
         inner join Room_Equipment_Xref as rex
				             on e.Equipment_ID = rex.Equipment_ID
			where rex.Room_number = e_room_number
			group by Room_number, Name, Manufacturer;

	/*  returns the room number of a given equipment */
	elseif (e_room_number is null) and (e_name is not null) and (e_group_flag is not null) and (e_id is null) then
		select Room_number
        ,COUNT(Name) as Number_of_eqp
        ,Name
        ,Manufacturer
			 from Equipment as e 
         inner join Room_Equipment_Xref as rex
				             on e.Equipment_ID = rex.Equipment_ID
			where e.Name = e_name
			group by Room_number, Name, Manufacturer;

	/*  returns all the equipment */
	elseif (e_room_number is null) and (e_name is null) and (e_group_flag is null) and (e_id is null) then
		select Room_number
        ,e.Equipment_ID
        ,Name
        ,Manufacturer
			 from Equipment as e 
         inner join Room_Equipment_Xref as rex
				             on e.Equipment_ID = rex.Equipment_ID;

	/*  returns all the equipment in a given room */
	elseif (e_room_number is not null) and (e_name is null) and (e_group_flag is null) and (e_id is null) then
		select Room_number
        ,e.Equipment_ID
        ,Name
        ,Manufacturer
    from Equipment as e 
         inner join Room_Equipment_Xref as rex
                 on e.Equipment_ID = rex.Equipment_ID
			where rex.Room_number = e_room_number;

	/*  returns the room number of a given equipment */
	elseif (e_room_number is null) and (e_name is not null) and (e_group_flag is null) and (e_id is null) then 
		select Room_number
        ,e.Equipment_ID
        ,Name
        ,Manufacturer
			 from Equipment as e 
         inner join Room_Equipment_Xref as rex
				             on e.Equipment_ID = rex.Equipment_ID
			where e.Name = e_name;

	/*  returns the equipment by ID */
	elseif (e_room_number is null) and (e_name is null) and (e_group_flag is null) and (e_id is not null) then 
		select Room_number
        ,e.Equipment_ID
        ,Name
        ,Manufacturer
			 from Equipment as e 
         inner join Room_Equipment_Xref as rex
				             on e.Equipment_ID = rex.Equipment_ID
			where e.Equipment_ID = e_id;

	end if;

end go
delimiter ;

