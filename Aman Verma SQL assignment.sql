use aman;
CREATE TABLE `aman`.`airbnb` (
  `listing_id` INT NOT NULL,
  `date` DATE NULL,
  `available` VARCHAR(1) NULL,
  `price` FLOAT NULL
);

load data local infile'D:/airbnb_calendar.csv'
into table airbnb
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from airbnb order by listing_id;

/*=============Q1===================*/

(select date from airbnb order by date limit 1)union(Select date from airbnb order by date desc limit 1);

/*=============Q2===================*/

delete sub from
(select row_number() over(partition by listing_id, date,available,price order by listing_id) cnt
 from airbnb) sub
where sub.cnt > 1;

/*=============Q3===================*/

select listing_id as property,sum(case when available = 't' then 1 else 0 end) as Available, 
sum(case when available = 'f' then 1 else 0 end) as Unavailable 
from airbnb
group by listing_id;

/*=============Q4===================*/

select listing_id ,percent from(
	select listing_id,(count(case when available ='t' then 1 end)/count(*))*100 as percent
    from airbnb
	group by listing_id
)as temp where percent > 50;
select listing_id ,percent from(
	select listing_id,(count(case when available ='t' then 1 end)/count(*))*100 as percent
    from airbnb
	group by listing_id
)as temp where percent > 75;

/*=============Q5===================*/

select listing_id as property,max(price) as Max, 
min(price) as Min, 
avg(price) as Average
from airbnb
group by listing_id;


/*=============Q6===================*/

select listing_id ,Price from (
            select avg(price) as Price, listing_id
            from airbnb
            group by listing_id
        )as temp     where Price> 500 ;
        