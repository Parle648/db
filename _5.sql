select 
	m.id,
	m.title,
	m.release_date ,
	m.description ,
    jsonb_build_object(
        'file_name', f.file_name,
        'mime_type', f.mime_type,
        'key', f.key,
        'url', f.url,
        'created_at', f.created_at,
        'updated_at', f.updated_at
    ) as poster,
    jsonb_build_object(
        'name', d.name,
        'surname', d.surname,
        'created_at', d.created_at,
        'updated_at', d.updated_at
    ) as director
from 
	movies m,
	files f,
	directors d 
where 
	m.director_id = d.id 
and
	m.poster_id = f.id
group by 
    m.id, m.title, m.release_date, m.description, f.file_name, f.mime_type, f.key, f.url, f.created_at, f.updated_at, d.name, d.surname, d.created_at, d.updated_at;