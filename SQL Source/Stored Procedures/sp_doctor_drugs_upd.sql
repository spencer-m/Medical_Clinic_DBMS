/*
Procedure: Update drug entry
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_drugs_upd;

delimiter go
create procedure sp_doctor_drugs_upd (
	 in d_id	int
	,in d_new_name	varchar(100)
	,in d_new_type varchar(30)
)
begin

	set d_new_name = nullif(d_new_name, '');
	set d_new_type = nullif(d_new_type, '');

	if (d_new_name is not null) and (d_new_type is not null) then
		update Drugs_Available as d
				set   d.Name = d_new_name
						,d.Type = d_new_type
						,d.Revision_user = user()
						,d.Revision_date = now()
				where d.Drug_id = d_id;

	elseif (d_new_name is not null) and (d_new_type is null) then
		update Drugs_Available as d
				set   d.Name = d_new_name
						,d.Revision_user = user()
						,d.Revision_date = now()
				where d.Drug_id = d_id;

	elseif (d_new_name is null) and (d_new_type is not null) then
		update Drugs_Available as d
				set    d.Type = d_new_type
						,d.Revision_user = user()
						,d.Revision_date = now()
				where d.Drug_id = d_id;

	end if;

end go
delimiter ;

