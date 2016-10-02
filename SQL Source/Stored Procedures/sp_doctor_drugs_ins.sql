/*
Procedure: Insert drug entry
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_drugs_ins;

delimiter go
create procedure sp_doctor_drugs_ins (
	 in d_DIN	int
	,in d_name	varchar(100)
	,in d_type	varchar(30)
)
begin

	insert into Drugs_Available (
						 DIN
						,Name
						,Type
						,Revision_user
						,Revision_date
	)
	values (
					 d_DIN
					,d_name
					,d_type
					,user()
					,now()
	);


end go
delimiter ;

