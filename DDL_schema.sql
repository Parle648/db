-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION postgres;

-- DROP TYPE public."Gender";

CREATE TYPE public."Gender" AS ENUM (
	'male',
	'female');

-- DROP TYPE public."MIME";

CREATE TYPE public."MIME" AS ENUM (
	'image_jpeg',
	'image_png',
	'image_gif',
	'image_webp',
	'image_svg_xml');

-- DROP TYPE public."Role";

CREATE TYPE public."Role" AS ENUM (
	'leading',
	'supporting',
	'background');

-- DROP SEQUENCE public.characters_id_seq;

CREATE SEQUENCE public.characters_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.directors_id_seq;

CREATE SEQUENCE public.directors_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.favorites_id_seq;

CREATE SEQUENCE public.favorites_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.files_id_seq;

CREATE SEQUENCE public.files_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.genres_id_seq;

CREATE SEQUENCE public.genres_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.movies_id_seq;

CREATE SEQUENCE public.movies_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.persons_id_seq;

CREATE SEQUENCE public.persons_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.users_id_seq;

CREATE SEQUENCE public.users_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- public."_prisma_migrations" определение


-- public.files определение

-- Drop table

-- DROP TABLE public.files;

CREATE TABLE public.files (
	id serial4 NOT NULL,
	file_name varchar(325) NOT NULL,
	mime_type public."MIME" NOT NULL,
	"key" text NOT NULL,
	url text NOT NULL,
	created_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	CONSTRAINT files_pkey PRIMARY KEY (id)
);
CREATE UNIQUE INDEX files_id_key ON public.files USING btree (id);


-- public.genres определение

-- Drop table

-- DROP TABLE public.genres;

CREATE TABLE public.genres (
	id serial4 NOT NULL,
	genre varchar(15) NOT NULL,
	created_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	CONSTRAINT genres_pkey PRIMARY KEY (id)
);
CREATE UNIQUE INDEX genres_id_key ON public.genres USING btree (id);


-- public.directors определение

-- Drop table

-- DROP TABLE public.directors;

CREATE TABLE public.directors (
	id serial4 NOT NULL,
	"name" varchar(15) NOT NULL,
	surname varchar(15) NOT NULL,
	created_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_at timestamp(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
	file_id int4 NOT NULL,
	CONSTRAINT directors_pkey PRIMARY KEY (id),
	CONSTRAINT directors_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE UNIQUE INDEX directors_file_id_key ON public.directors USING btree (file_id);
CREATE UNIQUE INDEX directors_id_key ON public.directors USING btree (id);


-- public.movies определение

-- Drop table

-- DROP TABLE public.movies;

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
);
CREATE UNIQUE INDEX movies_director_id_key ON public.movies USING btree (director_id);
CREATE UNIQUE INDEX movies_id_key ON public.movies USING btree (id);
CREATE UNIQUE INDEX movies_poster_id_key ON public.movies USING btree (poster_id);
CREATE UNIQUE INDEX movies_title_key ON public.movies USING btree (title);


-- public.persons определение

-- Drop table

-- DROP TABLE public.persons;

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
);
CREATE UNIQUE INDEX persons_file_id_key ON public.persons USING btree (file_id);
CREATE UNIQUE INDEX persons_id_key ON public.persons USING btree (id);


-- public."characters" определение

-- Drop table

-- DROP TABLE public."characters";

CREATE TABLE public."characters" (
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
);
CREATE UNIQUE INDEX characters_file_id_key ON public.characters USING btree (file_id);
CREATE UNIQUE INDEX characters_id_key ON public.characters USING btree (id);
CREATE UNIQUE INDEX characters_person_id_key ON public.characters USING btree (person_id);


-- public.favorites определение

-- Drop table

-- DROP TABLE public.favorites;

CREATE TABLE public.favorites (
	id serial4 NOT NULL,
	movie_id int4 NOT NULL,
	CONSTRAINT favorites_pkey PRIMARY KEY (id),
	CONSTRAINT favorites_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE UNIQUE INDEX favorites_id_key ON public.favorites USING btree (id);


-- public.movie_actors определение

-- Drop table

-- DROP TABLE public.movie_actors;

CREATE TABLE public.movie_actors (
	movie_id int4 NOT NULL,
	person_id int4 NOT NULL,
	CONSTRAINT movie_actors_pkey PRIMARY KEY (movie_id, person_id),
	CONSTRAINT movie_actors_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT movie_actors_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.persons(id) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- public.movie_genres определение

-- Drop table

-- DROP TABLE public.movie_genres;

CREATE TABLE public.movie_genres (
	movie_id int4 NOT NULL,
	genre_id int4 NOT NULL,
	CONSTRAINT movie_genres_pkey PRIMARY KEY (movie_id, genre_id),
	CONSTRAINT movie_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT movie_genres_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- public.users определение

-- Drop table

-- DROP TABLE public.users;

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
);
CREATE UNIQUE INDEX users_avatar_id_key ON public.users USING btree (avatar_id);
CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);
CREATE UNIQUE INDEX users_favorite_id_key ON public.users USING btree (favorite_id);
CREATE UNIQUE INDEX users_id_key ON public.users USING btree (id);
CREATE UNIQUE INDEX users_username_key ON public.users USING btree (username);
