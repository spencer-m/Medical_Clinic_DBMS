/*
Procedure:
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_supplies_sel;

delimiter go
create procedure sp_doctor_supplies_sel (
	 in s_room_number	int
	,in s_supplies_name	varchar(50)
	,in s_group_flag	varchar(1)
)
begin

	set s_supplies_name = nullif(s_supplies_name, '');
	set s_room_number = nullif(s_room_number, '');
	set s_group_flag = nullif(s_group_flag, '' or '0');

	/* returns amount of supplies by room number */
	if (s_room_number is null) and (s_supplies_name is not null)  and (s_group_flag is null) then
		select  ID
					,Room_number
					,Name
					,Supplier
					,Amount
			from Supplies as s join Room_Supplies_Xref as rsx
				on s.ID = rsx.Supplies_ID
			where s.Name = s_supplies_name;

	/* returns all supplies in a given room */
	elseif (s_room_number is not null) and (s_supplies_name is null) and (s_group_flag is null) then
		select	 ID
					,Room_number
					,Name
					,Supplier
					,Amount
			from Supplies as s join Room_Supplies_Xref as rsx
				on s.ID = rsx.Supplies_ID
			where rsx.Room_number = s_room_number;

	/* returns amount of a given supply in a given room */
	elseif (s_room_number is not null) and (s_supplies_name is not null) and (s_group_flag is null) then
		select  ID
					,Room_number
					,Name
					,Supplier
					,Amount
			from Supplies as s join Room_Supplies_Xref as rsx
				on s.ID = rsx.Supplies_ID
			where rsx.Room_number = s_room_number
				and s.Name = s_supplies_name;

	/* returns all the supplies */
	elseif (s_room_number is null) and (s_supplies_name is null) and (s_group_flag is null) then
		select  ID
					,Name
					,Supplier
			from Supplies
			order by ID;

	/* returns all the supplies ordered by room number */
	elseif (s_room_number is null) and (s_supplies_name is null) and (s_group_flag is not null) then
		select  ID
					,Name
					,Supplier
					,Room_number
					,Amount
			from Supplies as s join Room_Supplies_Xref as rsx
				on s.ID = rsx.Supplies_ID
			order by Room_number, Name;

	end if;

end go
delimiter ;

