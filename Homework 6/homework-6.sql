-- • Create a stored procedure, called add_song_to_album, which, when called, will insert a new song into the song table, associate it with an album, and optionally insert lyrics.
 CREATE OR REPLACE PROCEDURE add_song_to_album(
	a_name VARCHAR,
	b_name VARCHAR,
 	p_name VARCHAR,
    p_duration INTERVAL,
    p_explicit BOOLEAN
 ) LANGUAGE PLPGSQL AS $$
 DECLARE	
    v_artist_id INT;
    v_album_id INT;
 BEGIN
	INSERT INTO artist(name) VALUES (a_name) RETURNING id INTO v_artist_id;
	INSERT INTO album(name) VALUES (b_name) RETURNING id INTO v_album_id;
	
	INSERT INTO song(
	name,
    duration,
    explicit ,
	album_id,
	artist_id
	) VALUES(
-- 	b_name,
-- 	a_name,
	p_name,
    p_duration,
    p_explicit,
	v_album_id,
	v_artist_id
	);
 
 COMMIT;
 
 END;
 $$;
 
 CALL add_song_to_album('Nekoj artist'::VARCHAR,'Nekoja album'::VARCHAR,'Nekoja Pesna'::VARCHAR, '00:02:00'::INTERVAL,true);
 
--ERROR:  Key (id)=(13) already exists.duplicate key value violates unique constraint "album_pkey" 

-- ERROR:  duplicate key value violates unique constraint "album_pkey"
-- SQL state: 23505
-- Detail: Key (id)=(13) already exists.
-- Context: SQL statement "INSERT INTO album(name) VALUES (s_name) RETURNING id"
-- PL/pgSQL function add_song_to_album(character varying,character varying,character varying,interval,boolean) line 7 at SQL statement

-- PRI SPAM NA CALL GO DOBIV I OVOJ ERROR
-- ERROR:  INSERT has more expressions than target columns
-- LINE 13:  v_album_id,
--           ^
-- QUERY:  INSERT INTO song(
-- 	name,
--     duration,
--     explicit ,
-- 	album_id,
-- 	artist_id
-- 	) VALUES(
-- 		s_name,
-- 		a_name,
-- 	p_name,
--     p_duration,
--     p_explicit,
-- 	v_album_id,
-- 	v_artist_id
-- 	)
-- CONTEXT:  PL/pgSQL function add_song_to_album(character varying,character varying,character varying,interval,boolean) line 9 at SQL statement 

-- SQL state: 42601