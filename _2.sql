select  
	m.id,
	m.title,
	count(p.id) as actors_count
from 
	movies m,
	persons p ,
	movie_actors ma 
where 
	ma.movie_id = m.id 
and 
	ma.person_id = p.id 
and 
	m.release_date > '2019-07-06 00:00:00.000'
group by 
	m.id