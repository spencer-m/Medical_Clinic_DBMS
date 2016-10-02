/*
Procedure: select and view the bill(s) for a certain patient
*/
use HealthcareClinic;
drop procedure if exists sp_billing_sel;

delimiter go
create procedure sp_billing_sel(
	in	b_id	int
	,in b_flag	int
)
begin

	set b_id = nullif(b_id, '');
	set b_flag = nullif(b_flag, '');
	
	/* returns a specific invoice */
	if (b_flag is null) and (b_id is not null) then
		select  p.First_name
					,p.Last_name
					,b.Invoice_number
					,b.Amount
					,b.Balance
					,b.Paid
					,a.Date
					,b.Revision_date
		from Billing as b
				 inner join Appointment as a
					on b.Invoice_number = a.Invoice_number
				inner join Patient as p
					on a.Patient_id = p.Id
		where b.Invoice_number = b_id;

	/* returns the incompletely paid invoices */
	elseif (b_flag = 6) and (b_id is null) then
		select  p.First_name
					,p.Last_name
					,b.Invoice_number
					,b.Amount
					,b.Balance
					,b.Paid
					,a.Date
					,b.Revision_date
		from Billing as b
				 inner join Appointment as a
					on b.Invoice_number = a.Invoice_number
				inner join Patient as p
					on a.Patient_id = p.Id
		where b.Balance != 0;

	/* returns the completely paid invoices */
	elseif (b_flag = 4) and (b_id is null) then
		select  p.First_name
					,p.Last_name
					,b.Invoice_number
					,b.Amount
					,b.Balance
					,b.Paid
					,a.Date
					,b.Revision_date
		from Billing as b
				 inner join Appointment as a
					on b.Invoice_number = a.Invoice_number
				inner join Patient as p
					on a.Patient_id = p.Id
		where b.Balance = 0;

	end if;

end go
delimiter ;

