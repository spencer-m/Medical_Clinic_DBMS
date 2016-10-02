/*
Procedure: View drug attributes
*/
use HealthcareClinic;
drop procedure if exists sp_doctor_drugs_sel;

delimiter go
create procedure sp_doctor_drugs_sel (
	 in d_id	int
	,in d_name	varchar(100)
)
begin

	set d_id = nullif(d_id, '');
	set d_name = nullif(d_name, '');

	if (d_id is null) and (d_name  is null) then
		select  d.Name
					,d.Type
					,d.Drug_id
     ,d.DIN
			from Drugs_Available as d
			order by Name;

	elseif (d_id is not null) and (d_name is null) then
		select  d.Name
					,d.Type
					,d.Drug_id
     ,d.DIN
			from Drugs_Available as d
			where d.Drug_ID = d_id;

	elseif (d_id is null) and (d_name  is not null) then
		select  d.Name
					,d.Type
					,d.Drug_id
     ,d.DIN
			from Drugs_Available as d
			where d.Name = d_name;

	elseif (d_id is not null) and (d_name  is not null) then
		select  d.Name
					,d.Type
					,d.Drug_id
     ,d.DIN
			from Drugs_Available as d
			where d.Name = d_name
				and d.Drug_ID = d_id;

	end if;

end go
delimiter ;

