/*
Procedure: Delete a supply table entry for a unique room
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_supplies_del;

delimiter go
create procedure sp_doctor_supplies_del (
	 in s_id	int
	,in s_room_number	int
)
begin

	set s_id = nullif(s_id, '');
	set s_room_number = nullif(s_room_number, -1);

	if (s_id is not null) and (s_room_number is not null) then

		delete rsx
			from Room_Supplies_Xref as rsx
			where rsx.Supplies_id = s_id
				and	rsx.Room_number = s_room_number;

	elseif (s_id is not null) and (s_room_number is null) then

		delete s
			from Supplies as s
			where s.ID = s_id;

	end if;

end go
delimiter ;

