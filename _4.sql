select 
	d.id,
	d."name" ,
	d.surname, 
	avg(m.budget) as budget
from
	directors d,
	movies m
where 
	d.id = m.director_id
group by 
	d.id