
use exemplos;

drop table if exists mountain;

create table mountain (
ID int, 
NAME varchar(20),
HEIGHT INT,
COUNTRY_ID int,
)

drop table if exists country;

create table country (
ID INT,
NAME varchar(20),
POPULATION int,
AREA int
)

insert into country values (1,  'France',			66600000,	640680);
insert into country values (2,  'Germany',			80700000,	357000);
insert into country values (3,	'Liechtenstein',	37340,		160);
insert into country values (4,	'Spain',			46464000,	505990);
insert into country values (5,	'Italy', 			60795000,	301300);


insert into mountain values (1,	'Mont Blanc',		4808,	1);
insert into mountain values (2,	'Barre des Ecrins',	4100,	1);
insert into mountain values (3,	'Zugspitze',		2962,	2);
insert into mountain values (4,	'Schneefernerkopf',	2874,	2);
insert into mountain values (5,	'Naafkopf',			2570,	3);
insert into mountain values (6,	'Mulhacen',			3478,	4);
insert into mountain values (7,	'Corno Grande',		2912,	5);
insert into mountain values (8,	'Monte Amaro',		2793,	5);


SELECT *
FROM country
WHERE EXISTS (
  SELECT *
  FROM mountain
  WHERE country_id = country.id
);


SELECT DISTINCT country.*
FROM country INNER JOIN mountain ON country_id = country.id

SELECT *
FROM country
WHERE id IN (SELECT COUNTRY_ID
             FROM mountain)
 



