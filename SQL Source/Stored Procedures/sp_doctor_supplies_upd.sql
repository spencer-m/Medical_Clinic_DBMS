/*
Procedure: Update a supply entry
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_supplies_upd;

delimiter go
create procedure sp_doctor_supplies_upd (
	 in s_id	int
	,in s_room_number	int
	,in s_name	varchar(50)
	,in s_supplier	varchar(45)
	,in s_amount	int
)
begin

	set s_id = nullif(s_id, '');
	set s_room_number = nullif(s_room_number, -1);	
	set s_name = nullif(s_name, '');
	set s_supplier = nullif(s_supplier, '');
	set s_amount = nullif(s_amount, -1);

	if (s_id is not null) and (s_room_number is not null) and (s_name is null) and (s_supplier is null) and (s_amount is not null) then

		update Room_Supplies_Xref as rsx
			set	 rsx.Amount = s_amount
					,rsx.Revision_user = user()
					,rsx.Revision_date = now()
		where rsx.Supplies_ID = s_id
			and rsx.Room_number = s_room_number;

	elseif (s_id is not null) and (s_room_number is null) and (s_name is not null) and (s_supplier is not null) and (s_amount is null) then

		update Supplies as s
			set 	 s.Name = s_name
					,s.Supplier = s_supplier
			where s.ID = s_id;

	end if;

end go
delimiter ;

