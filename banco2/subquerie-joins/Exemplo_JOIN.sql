drop table if exists aluno;
drop table if exists notebook;

--FILHA
create table aluno(
codigo_aluno int,
aluno varchar(10),
codigo_notebook int)

--PAI
create table notebook (
codigo_notebook int,
notebook varchar(10))

truncate table aluno;
truncate table notebook;

insert into aluno values (1, 'A', 1);
insert into aluno values (2, 'B', 1);
insert into aluno values (3, 'C', null);
insert into aluno values (4, 'D', null);

insert into notebook values (1, 'Dell');
insert into notebook values (2, 'Acer');
insert into notebook values (3, 'HP');

select * from aluno a inner join notebook n on a.codigo_notebook = n.codigo_notebook
select * from aluno a left join notebook n on a.codigo_notebook = n.codigo_notebook
select * from aluno a right join notebook n on a.codigo_notebook = n.codigo_notebook
select * from aluno a full outer join notebook n on a.codigo_notebook = n.codigo_notebook
select * from aluno a cross join notebook




