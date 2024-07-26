SELECT 
    m.id,
    m.title,
    m.release_date,
    m.duration,
    m.description,
    jsonb_build_object(
        'id', f.id,
        'file_name', f.file_name,
        'mime_type', f.mime_type,
        'key', f.key,
        'url', f.url,
        'created_at', f.created_at,
        'updated_at', f.updated_at
    ) AS poster,
    jsonb_build_object(
        'id', d.id,
        'first_name', d.name,
        'last_name', d.surname,
        'photo', jsonb_build_object(
            'id', df.id,
            'file_name', df.file_name,
            'mime_type', df.mime_type,
            'key', df.key,
            'url', df.url,
            'created_at', df.created_at,
            'updated_at', df.updated_at
        )
    ) AS director,
    jsonb_agg(
        jsonb_build_object(
            'id', p.id,
            'first_name', p.first_name,
            'last_name', p.last_name,
            'photo', jsonb_build_object(
                'id', pf.id,
                'file_name', pf.file_name,
                'mime_type', pf.mime_type,
                'key', pf.key,
                'url', pf.url,
                'created_at', pf.created_at,
                'updated_at', pf.updated_at
            )
        )
    ) AS actors,
    jsonb_agg(
        jsonb_build_object(
            'id', g.id,
            'name', g.genre
        )
    ) AS genres
FROM 
    movies m
JOIN 
    files f ON m.poster_id = f.id
JOIN 
    directors d ON m.director_id = d.id
JOIN 
    files df ON d.file_id = df.id
LEFT JOIN 
    movie_actors ma ON m.id = ma.movie_id
LEFT JOIN 
    persons p ON ma.person_id = p.id
LEFT JOIN 
    files pf ON p.file_id = pf.id
LEFT JOIN 
    movie_genres mg ON m.id = mg.movie_id
LEFT JOIN 
    genres g ON mg.genre_id = g.id
WHERE 
    m.id = 1
GROUP BY 
    m.id, m.title, m.release_date, m.duration, m.description, f.id, d.id, df.id;
