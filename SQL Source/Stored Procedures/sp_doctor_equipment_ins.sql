/*
Procedure: Insert an equipment entry
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_equipment_ins;

delimiter go
create procedure sp_doctor_equipment_ins (
	 in e_name	varchar(50)
	,in e_manufacturer	varchar(250)
	,in e_room_number	int
)
begin

	set @e_user = user();
	set @e_date = now();

	insert into Equipment (
		 Equipment_ID
		,Name
		,Manufacturer
		,Revision_user
		,Revision_date
	)
	value (
		 null
		,e_name
		,e_manufacturer
		,@e_user
		,@e_date
	);

	insert into Room_Equipment_Xref (
		 Room_number
		,Equipment_ID
		,Revision_user
		,Revision_date
	)
	value (
		 e_room_number
		,LAST_INSERT_ID()
		,@e_user
		,@e_date
	);

end go
delimiter ;

