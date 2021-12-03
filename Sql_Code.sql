create trigger update_rating
after insert on feedback
for each row execute procedure process_update_rating();

create or replace function process_update_rating()
returns trigger as $updaterating$
declare
t_driverid DECIMAL(4,0);
begin
IF new.booking_id is not null then
select driver_id into t_driverid from ride where booking_id=new.booking_id;

IF new.rating_drive<2 then 
	update driver set rating=rating-0.2 where driver_id=t_driverid;
END IF;
END IF;
return null;
end $updaterating$ LANGUAGE 'plpgsql';
