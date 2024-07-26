CREATE SCHEMA public AUTHORIZATION postgres;

CREATE OR REPLACE FUNCTION deploy_schema() RETURNS void AS $$
BEGIN
    EXECUTE 'DROP SCHEMA IF EXISTS public CASCADE';
    EXECUTE 'CREATE SCHEMA public AUTHORIZATION postgres';

    EXECUTE 'CREATE TYPE public."Gender" AS ENUM (''male'', ''female'')';
    EXECUTE 'CREATE TYPE public."MIME" AS ENUM (''image_jpeg'', ''image_png'', ''image_gif'', ''image_webp'', ''image_svg_xml'')';
    EXECUTE 'CREATE TYPE public."Role" AS ENUM (''leading'', ''supporting'', ''background'')';

    EXECUTE 'CREATE SEQUENCE public.characters_id_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE';
    EXECUTE 'CREATE SEQUENCE public.directors_id_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE';
    EXECUTE 'CREATE SEQUENCE public.favorites_id_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE';
    EXECUTE 'CREATE SEQUENCE public.files_id_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE';
    EXECUTE 'CREATE SEQUENCE public.genres_id_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE';
    EXECUTE 'CREATE SEQUENCE public.movies_id_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE';
    EXECUTE 'CREATE SEQUENCE public.persons_id_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE';
    EXECUTE 'CREATE SEQUENCE public.users_id_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE';

    EXECUTE '
    CREATE TABLE public.files (
        id serial4 NOT NULL,
        file_name varchar(325) NOT NULL,
        mime_type public."MIME" NOT NULL,
        "key" text NOT NULL,
        url text NOT NULL,
        created_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
        CONSTRAINT files_pkey PRIMARY KEY (id)
    )';
    EXECUTE 'CREATE UNIQUE INDEX files_id_key ON public.files USING btree (id)';

    EXECUTE '
    CREATE TABLE public.genres (
        id serial4 NOT NULL,
        genre varchar(15) NOT NULL,
        created_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
        CONSTRAINT genres_pkey PRIMARY KEY (id)
    )';
    EXECUTE 'CREATE UNIQUE INDEX genres_id_key ON public.genres USING btree (id)';

    EXECUTE '
    CREATE TABLE public.directors (
        id serial4 NOT NULL,
        "name" varchar(15) NOT NULL,
        surname varchar(15) NOT NULL,
        created_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
        file_id int4 NOT NULL,
        CONSTRAINT directors_pkey PRIMARY KEY (id),
        CONSTRAINT directors_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE RESTRICT ON UPDATE CASCADE
    )';
    EXECUTE 'CREATE UNIQUE INDEX directors_file_id_key ON public.directors USING btree (file_id)';
    EXECUTE 'CREATE UNIQUE INDEX directors_id_key ON public.directors USING btree (id)';

    EXECUTE '
    CREATE TABLE public.movies (
        id serial4 NOT NULL,
        title text NOT NULL,
        description text NOT NULL,
        budget int4 NOT NULL,
        release_date timestamp(3) NOT NULL,
        duration int4 NOT NULL,
        created_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
        director_id int4 NOT NULL,
        poster_id int4 DEFAULT 5 NOT NULL,
        genre_id int4 NOT NULL,
        CONSTRAINT movies_pkey PRIMARY KEY (id),
        CONSTRAINT movies_director_id_fkey FOREIGN KEY (director_id) REFERENCES public.directors(id) ON DELETE RESTRICT ON UPDATE CASCADE,
        CONSTRAINT movies_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(id) ON DELETE RESTRICT ON UPDATE CASCADE,
        CONSTRAINT movies_poster_id_fkey FOREIGN KEY (poster_id) REFERENCES public.files(id) ON DELETE RESTRICT ON UPDATE CASCADE
    )';
    EXECUTE 'CREATE UNIQUE INDEX movies_director_id_key ON public.movies USING btree (director_id)';
    EXECUTE 'CREATE UNIQUE INDEX movies_id_key ON public.movies USING btree (id)';
    EXECUTE 'CREATE UNIQUE INDEX movies_poster_id_key ON public.movies USING btree (poster_id)';
    EXECUTE 'CREATE UNIQUE INDEX movies_title_key ON public.movies USING btree (title)';

    EXECUTE '
    CREATE TABLE public.persons (
        id serial4 NOT NULL,
        first_name varchar(15) NOT NULL,
        last_name varchar(15) NOT NULL,
        biography text NOT NULL,
        date_of_birth timestamp(3) NOT NULL,
        "gender" public."Gender" NOT NULL,
        created_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
        file_id int4 NOT NULL,
        CONSTRAINT persons_pkey PRIMARY KEY (id),
        CONSTRAINT persons_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE RESTRICT ON UPDATE CASCADE
    )';
    EXECUTE 'CREATE UNIQUE INDEX persons_file_id_key ON public.persons USING btree (file_id)';
    EXECUTE 'CREATE UNIQUE INDEX persons_id_key ON public.persons USING btree (id)';

    EXECUTE '
    CREATE TABLE public.characters (
        id serial4 NOT NULL,
        "name" varchar(15) NOT NULL,
        description text NOT NULL,
        "role" public."Role" NOT NULL,
        created_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
        person_id int4 NOT NULL,
        file_id int4 NOT NULL,
        CONSTRAINT characters_pkey PRIMARY KEY (id),
        CONSTRAINT characters_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE RESTRICT ON UPDATE CASCADE,
        CONSTRAINT characters_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.persons(id) ON DELETE RESTRICT ON UPDATE CASCADE
    )';
    EXECUTE 'CREATE UNIQUE INDEX characters_file_id_key ON public.characters USING btree (file_id)';
    EXECUTE 'CREATE UNIQUE INDEX characters_id_key ON public.characters USING btree (id)';
    EXECUTE 'CREATE UNIQUE INDEX characters_person_id_key ON public.characters USING btree (person_id)';

    EXECUTE '
    CREATE TABLE public.favorites (
        id serial4 NOT NULL,
        movie_id int4 NOT NULL,
        CONSTRAINT favorites_pkey PRIMARY KEY (id),
        CONSTRAINT favorites_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id) ON DELETE RESTRICT ON UPDATE CASCADE
    )';
    EXECUTE 'CREATE UNIQUE INDEX favorites_id_key ON public.favorites USING btree (id)';

    EXECUTE '
    CREATE TABLE public.movie_actors (
        movie_id int4 NOT NULL,
        person_id int4 NOT NULL,
        CONSTRAINT movie_actors_pkey PRIMARY KEY (movie_id, person_id),
        CONSTRAINT movie_actors_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id) ON DELETE RESTRICT ON UPDATE CASCADE,
        CONSTRAINT movie_actors_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.persons(id) ON DELETE RESTRICT ON UPDATE CASCADE
    )';

    EXECUTE '
    CREATE TABLE public.movie_genres (
        movie_id int4 NOT NULL,
        genre_id int4 NOT NULL,
        CONSTRAINT movie_genres_pkey PRIMARY KEY (movie_id, genre_id),
        CONSTRAINT movie_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(id) ON DELETE RESTRICT ON UPDATE CASCADE,
        CONSTRAINT movie_genres_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id) ON DELETE RESTRICT ON UPDATE CASCADE
    )';

    EXECUTE '
    CREATE TABLE public.users (
        id serial4 NOT NULL,
        username varchar(15) NOT NULL,
        first_name varchar(15) NOT NULL,
        last_name varchar(15) NOT NULL,
        email varchar(320) NOT NULL,
        "password" text NOT NULL,
        created_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
        avatar_id int4 NOT NULL,
        favorite_id int4 DEFAULT 1 NOT NULL,
        CONSTRAINT users_pkey PRIMARY KEY (id),
        CONSTRAINT users_avatar_id_fkey FOREIGN KEY (avatar_id) REFERENCES public.files(id) ON DELETE RESTRICT ON UPDATE CASCADE,
        CONSTRAINT users_favorite_id_fkey FOREIGN KEY (favorite_id) REFERENCES public.favorites(id) ON DELETE RESTRICT ON UPDATE CASCADE
    )';
    EXECUTE 'CREATE UNIQUE INDEX users_avatar_id_key ON public.users USING btree (avatar_id)';
    EXECUTE 'CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email)';
    EXECUTE 'CREATE UNIQUE INDEX users_favorite_id_key ON public.users USING btree (favorite_id)';
    EXECUTE 'CREATE UNIQUE INDEX users_id_key ON public.users USING btree (id)';
    EXECUTE 'CREATE UNIQUE INDEX users_username_key ON public.users USING btree (username)';

    EXECUTE '
    INSERT INTO public.genres (genre) VALUES
    (''Action''), (''Comedy''), (''Drama''), (''Fantasy''), (''Horror'')';

    EXECUTE '
    INSERT INTO public.files (file_name, mime_type, "key", url) VALUES
    (''poster1.jpg'', ''image_jpeg'', ''poster1_key'', ''http://example.com/poster1.jpg''),
    (''poster2.jpg'', ''image_jpeg'', ''poster2_key'', ''http://example.com/poster2.jpg''),
    (''director_photo.jpg'', ''image_jpeg'', ''director_photo_key'', ''http://example.com/director_photo.jpg''),
    (''actor_photo.jpg'', ''image_jpeg'', ''actor_photo_key'', ''http://example.com/actor_photo.jpg'')';

    EXECUTE '
    INSERT INTO public.directors ("name", surname, file_id) VALUES
    (''Steven'', ''Spielberg'', 3)';

    EXECUTE '
    INSERT INTO public.movies (title, description, budget, release_date, duration, director_id, poster_id, genre_id) VALUES
    (''Jurassic Park'', ''Dinosaurs on the loose'', 63000000, ''1993-06-11 00:00:00'', 127, 1, 1, 1)';

    EXECUTE '
    INSERT INTO public.persons (first_name, last_name, biography, date_of_birth, "gender", file_id) VALUES
    (''Sam'', ''Neill'', ''An actor known for Jurassic Park'', ''1947-09-14 00:00:00'', ''male'', 4)';

    EXECUTE '
    INSERT INTO public.characters ("name", description, "role", person_id, file_id) VALUES
    (''Dr. Alan Grant'', ''Paleontologist'', ''leading'', 1, 4)';

    EXECUTE '
    INSERT INTO public.favorites (movie_id) VALUES
    (1)';

    EXECUTE '
    INSERT INTO public.users (username, first_name, last_name, email, "password", avatar_id, favorite_id) VALUES
    (''john_doe'', ''John'', ''Doe'', ''john.doe@example.com'', ''hashed_password'', 1, 1)';

END;
$$ LANGUAGE plpgsql;

SELECT deploy_schema();
