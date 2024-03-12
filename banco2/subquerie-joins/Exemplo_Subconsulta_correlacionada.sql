
drop table if exists city;

create table city (
ID int,
NAME varchar(10),
COUNTRY_ID INT,
POPULATION	INT,
AREA INT,
RATING INT
)

insert into city values (1,	'Paris',		1,	2243000,	102,	5);
insert into city values (2,	'Marseille',	1,	850700,		240,	4);
insert into city values (3,	'Lyon',			1,	484300,		48,		4);
insert into city values (4,	'Berlin',		2,	3460000,	888,	3);
insert into city values (5,	'Hamburg',		2,	1786000,	755,	3);
insert into city values (6,	'Munich',		2,	1353000,	310,	4);
insert into city values (7,	'Vaduz',		3,	5400,		17,		3);
insert into city values (8,	'Madrid',		4,	3165000,	605,	5);
insert into city values (9,	'Barcelona',	4,	1620000,	102,	5);
insert into city values (10, 'Valencia',	4,	809000,		135,	3);
insert into city values (11, 'Rome',		5,	2869000,	1285,	5);
insert into city values (12, 'Milan',		5,	1337000,	180,	3);

SELECT *
FROM city main_city
WHERE rating > (
  SELECT AVG(rating)
  FROM city average_city
  WHERE average_city.country_id = main_city.country_id
);

