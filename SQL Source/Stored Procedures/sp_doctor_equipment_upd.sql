/*
Procedure: Update an equipment entry
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_equipment_upd;

delimiter go
create procedure sp_doctor_equipment_upd (
	 in e_id	int
	,in e_new_name	varchar(50)
	,in e_new_manufacturer	varchar(250)
	,in e_new_room_number	int
)

begin

	set @e_name = (select Name
			from Equipment as e join Room_Equipment_Xref as rex
				on e.Equipment_ID = rex.Equipment_ID
			where e.Equipment_ID = e_id);

	set @e_manufacturer = (select Manufacturer
			from Equipment as e join Room_Equipment_Xref as rex
				on e.Equipment_ID = rex.Equipment_ID
			where e.Equipment_ID = e_id);

	set @e_room_number = (select Room_number
			from Equipment as e join Room_Equipment_Xref as rex
				on e.Equipment_ID = rex.Equipment_ID
			where e.Equipment_ID = e_id);

	if (e_new_name = '' or null) then
		set e_new_name = @e_name;
	end if;
	if (e_new_manufacturer = '' or null) then
		set e_new_manufacturer = @e_manufacturer;
	end if;
	if (e_new_room_number = '' or null) then
		set e_new_room_number = @e_room_number;
	end if;
	
	set @e_user = user();
	set @e_date = now();

	update Equipment as e join Room_Equipment_Xref as rex
			on e.Equipment_ID = rex.Equipment_ID
			set   e.Name = e_new_name
					,e.Manufacturer = e_new_manufacturer
					,e.Revision_user = @e_user
					,e.Revision_date = @e_date
					,rex.Room_number = e_new_room_number
					,rex.Revision_user = @e_user
					,rex.Revision_date = @e_date
			where e.Equipment_ID = e_id;

end go
delimiter ;

