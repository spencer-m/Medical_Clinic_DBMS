/*
Procedure: select and view the bill(s) for a certain patient
*/
use HealthcareClinic;
drop procedure if exists sp_billing_upd;

delimiter go
create procedure sp_billing_upd(
	 in	b_id	int
	,in	b_paid_add	decimal(15,2)
)
begin

update Billing as b
			set   b.Paid = (b.Paid + b_paid_add)
					,b.Balance = (b.Balance - b_paid_add)
					,b.Revision_user = user()
					,b.Revision_date = now()
			where b.Invoice_number = b_id;
end go
delimiter ;

