/*
Procedure: Insert a supply
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_supplies_ins;

delimiter go
create procedure sp_doctor_supplies_ins (
	 in s_name	varchar(50)
	,in s_supplier	varchar(45)
	,in s_room_number	int
	,in s_amount	int
)
begin
 declare s_user varchar(30);
 declare s_date datetime;
 declare s_id   int;
 declare s_flag int;
 
	set s_user = user();
	set s_date = now();
	
	
	set s_id = (select ID 
								from Supplies as s
								where s.Name = s_name
									and	s.Supplier = s_supplier
								order by ID
								limit 1);
	

	if (s_id is null) then

		insert into Supplies (
     Name
				,Supplier
				,Revision_user
				,Revision_date
		)
		values (
				 s_name
				,s_supplier
				,s_user
				,s_date
		);

		insert into Room_Supplies_Xref (
				 Room_number
				,Supplies_ID
				,Amount
				,Revision_user
				,Revision_date
		)
		values (
				 s_room_number
				,LAST_INSERT_ID()
				,s_amount
				,s_user
				,s_date
		);
	
	else 
	
		set s_flag = exists (select * 
												from Room_Supplies_Xref as rsx
												where rsx.Room_number = s_room_number
													and	rsx.Supplies_id = s_id);
		
		if (s_flag = 1) then
			update  Room_Supplies_Xref
				set	  Amount = Amount + s_amount
				where Supplies_id = s_id;

   select 'hello';
		else

		insert into Room_Supplies_Xref (
				Room_number
				,Supplies_ID
				,Amount
				,Revision_user
				,Revision_date
		)
		values (
				s_room_number
				,s_id
				,s_amount
				,s_user
				,s_date
		);
		end if;

	end if;
	

end go
delimiter ;

