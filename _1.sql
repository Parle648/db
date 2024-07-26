select 
	p.id,
	p.first_name,
	p.last_name, 
	SUM(m.budget) as budget
from
	persons p,
	movies m,
	movie_actors ma 
where 
	p.id = ma.person_id 
and 
	m.id = ma.movie_id
group by 
	p.id