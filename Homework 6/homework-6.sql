-- • Create a stored procedure, called add_song_to_album, which, when called, will insert a new song into the song table, associate it with an album, and optionally insert lyrics.

 CREATE OR REPLACE PROCEDURE add_song_to_album(
 	p_name VARCHAR,
    p_duration INTERVAL,
    p_explicit BOOLEAN
 ) LANGUAGE PLPGSQL AS $$
 DECLARE	
    artist_id INT REFERENCES artist(id);
    album_id INT REFERENCES album(id);
 BEGIN
 	
	INSERT INTO song(name) VALUES (p_name) RETURNING id INTO 
 
 END;
 $$;