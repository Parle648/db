select 
	u.id,
	u.username,
	array_agg(f.movie_id) as favorite_movies_ids 
from 
	users u,
	favorites f 
group by
	u.id