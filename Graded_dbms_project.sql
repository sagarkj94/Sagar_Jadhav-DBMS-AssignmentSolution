Create Database if not exists `travelOnTheGo`;
use `travelOnTheGo`;

/* 1. Create tables */

create table if not exists `PASSENGER`(
`Passenger_name`  varchar(50) NOT NULL,
`Category` varchar(10) NOT NULL,
`Gender` CHAR NOT NULL,
`Boarding_City` varchar(10) NOT NULL,
`Destination_City` varchar(10) NOT NULL,
`Distance` int NOT NULL,
`Bus_Type` varchar(20) NOT NULL
);
create table if not exists `PRICE`(
 `Bus_Type` varchar(20) NOT NULL,
 `Distance` int NOT NULL,
 `Price` int NOT NULL
 );
 
 /* 2. Insert tables */
 
insert into `PASSENGER` values("Sejal","AC",'F',"Bengaluru","Chennai",350,"Sleeper");
insert into `PASSENGER` values("Anmol","Non-AC",'M',"Mumbai","Hyderabad",700,"Sitting");
insert into `PASSENGER` values("Pallavi","AC",'F',"Panaji","Bengaluru",600,"Sleeper");
insert into `PASSENGER` values("Khusboo","AC",'F',"Chennai","Mumbai",1500,"Sleeper");
insert into `PASSENGER` values("Udit","Non-AC",'M',"Trivandrum","Panaji",1000,"Sleeper");

insert into `PASSENGER` values("Ankur","AC",'M',"Nagpur","Hyderabad",500,"Sitting");
insert into `PASSENGER` values("Hemant","Non-AC",'M',"Panaji","Mumbai",700,"Sleeper");
insert into `PASSENGER` values("Manish","Non-AC",'M',"Hyderabad","Bengaluru",500,"Sitting");
insert into `PASSENGER` values("Piyush","AC",'M',"Pune","Nagpur",700,"Sitting");

insert into `PRICE` values("Sleeper", 350,770);
insert into `PRICE` values("Sleeper",500,1100);
insert into `PRICE` values("Sleeper",600,1320);
insert into `PRICE` values("Sleeper",700,1540);
insert into `PRICE` values("Sleeper",1000,2200);
insert into `PRICE` values("Sleeper",1200,2640);
insert into `PRICE` values("Sleeper",1500,2700);
insert into `PRICE` values("Sitting",500,620);
insert into `PRICE` values("Sitting",600,744);
insert into `PRICE` values("Sitting",700,868);
insert into `PRICE` values("Sitting",1000,1240);
insert into `PRICE` values("Sitting",1200,1488);
insert into `PRICE` values("Sitting",1500,1860);

select * from passenger;

/*3. How many females and how many male passengers travelled for a minimum distance of
600 KM s?*/
select COUNT(CASE WHEN (Gender) = 'F' THEN 1 END) Female,COUNT(CASE WHEN (Gender) = 'M' THEN 1 END) Male from passenger where Distance >=600;

/*4. Find the minimum ticket price for Sleeper Bus. */
select MIN(price) from price where Bus_Type = 'sleeper';

/*5. Select passenger names whose names start with character 'S' */
select passenger.Passenger_name from passenger where Passenger_name like 's%';

/* 6. Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output */

select passenger.Passenger_name , passenger.Boarding_City, passenger.Destination_city, passenger.Bus_Type, price.Price from passenger inner join price on passenger.Distance = price.Distance and passenger.Bus_type = price.Bus_type;

/* 7. What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
for a distance of 1000 KM s */

select passenger.Passenger_name, price.Price FROM passenger inner join price on passenger.Distance = price.Distance and passenger.Bus_type = price.Bus_type WHERE passenger.Distance = 1000 and passenger.Bus_type = 'Sitting';

/* 8. What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji? */ 

select distinct passenger.Passenger_name, passenger.Boarding_city as Destination_city, passenger.Destination_city as Boardng_city, price.Bus_type, price.Price from passenger, price where Passenger_name = 'Pallavi' and passenger.Distance = price.Distance;

/*9. List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order. */

select distinct distance from passenger order by Distance desc;

/*10. Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables */

select passenger.Passenger_name, passenger.Distance * 100.0/ (select SUM(Distance) from passenger) from passenger;

/*11. Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500 
c) Cheap otherwise
*/
	SELECT passenger.Distance, price.Price,
CASE
    WHEN price.Price > 1000 THEN 'Expensive'
    WHEN price.Price < 1000 and price.Price > 500 THEN 'Average Cost'
    ELSE 'Cheap'
END AS Categories
FROM passenger inner join price on passenger.Distance = price.Distance and passenger.Bus_type = price.Bus_type;


