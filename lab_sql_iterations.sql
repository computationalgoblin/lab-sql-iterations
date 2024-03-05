select s.store_id, sum(p.amount) as `total_sales`
from store s
join staff st on s.manager_staff_id = st.staff_id
join payment p on st.staff_id = p.staff_id
group by s.store_id;
    
-- 
DELIMITER //

create procedure TotalSalesPerStore()
begin
    select s.store_id, sum(p.amount) as total_sales
    from store s
    join staff st on s.manager_staff_id = st.staff_id
    join payment p on st.staff_id = p.staff_id
    group by s.store_id;
end //

DELIMITER ;

call TotalSalesPerStore();

-- 

DELIMITER //

create procedure TotalSalesForStore(in storeId int)
begin
    select s.store_id, sum(p.amount) as `total_sales`
    from store s
    join staff st on s.manager_staff_id = st.staff_id
    join payment p on st.staff_id = p.staff_id
    where s.store_id = storeId
    group by s.store_id;
end //

DELIMITER ;

call TotalSalesForStore(1);

--

DELIMITER //

create procedure TotalSalesForStore1(in storeId int)
begin
    declare total_sales float;
    select sum(p.amount) into total_sales
    from store s
    join staff st on s.manager_staff_id = st.staff_id
    join payment p on st.staff_id = p.staff_id
    where s.store_id = storeId;
    select total_sales as `total_sales_for_store`;
end //

DELIMITER ;

call TotalSalesForStore1(1);

-- 

DELIMITER //

create procedure Flags(in storeId int)
begin
    declare total_sales float;
    declare flags VARCHAR(50);
	select sum(p.amount) into total_sales
    from store s
    join staff st on s.manager_staff_id = st.staff_id
    join payment p on st.staff_id = p.staff_id
    where s.store_id = storeId;
    set flags = case
        when total_sales > 30000 then 'green_flag'
        else 'red_flag'
    end;

    select total_sales as `total_sales_for_store`, flags AS `sales`;
end //

DELIMITER ;

-- Calling it:
call Flags(1);