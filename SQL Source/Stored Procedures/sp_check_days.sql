use HealthcareClinic;
drop procedure if exists sp_check_days;

delimiter go
create procedure sp_check_days(
		in startDate datetime,
        in endDate datetime,
        in eid int(11)
)



begin
	declare currhour, endhour datetime;


	DROP TABLE IF EXISTS days;
	CREATE TEMPORARY TABLE days(
	       day datetime
	);
    
    
    
    set currHour = startDate;
	set endhour = endDate;

REPEAT

	insert into days(
    day
    )
    values (
    currHour
    );
    

Set currHour = DATE_ADD(currHour,INTERVAL 24 HOUR);
UNTIL currHour > endhour END REPEAT;

	select *
    from days
    where  
    not exists (select *
				from scheduled_for
                where days.day = scheduled_for.Work_day_date
                and scheduled_for.Employee_id = eid
                );
                
end go
delimiter ;

