-- • Create a function that returns all information from the artist details table for a given artist id, using a row variable.
CREATE OR REPLACE FUNCTION get_all_info_from_artist(artist_name VARCHAR)
RETURNS TABLE(
    date_of_birth DATE ,
    full_name VARCHAR,
    country VARCHAR,
    city VARCHAR,
    is_married BOOLEAN ,
    spouse_name VARCHAR
) AS $$
BEGIN
 RETURN QUERY 
  SELECT ad.date_of_birth, ad.full_name, ad.country, ad.city, ad.is_married, COALESCE(ad.spouse_name,'Unknown') as spouse_name FROM artist ar
  JOIN artist_details ad ON ar.id = ad.artist_id
  WHERE ar.name = artist_name;
END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM get_all_info_from_artist('Eminem') --OVA E BEZ ROW smth
-- • Create a function doing the same thing as above but using a record.
--NE GO RABIRAM BARANJETO (DA SE POKAZE NAREDEN CAS)
-- • Create a function that will return all rock songs, determined by the artist id, with all of the artist details.
CREATE OR REPLACE FUNCTION return_all_rock_songs_by_artist_with_details(v_artist_id INT, genre_name VARCHAR)
RETURNS TABLE(
	song_name VARCHAR,
	date_of_birth DATE ,
    full_name VARCHAR,
    country VARCHAR,
    city VARCHAR,
    is_married BOOLEAN ,
    spouse_name VARCHAR
) AS $$
BEGIN
RETURN QUERY
  SELECT s.name as song_name, ad.date_of_birth, ad.full_name, ad.country, ad.city, ad.is_married, COALESCE(ad.spouse_name,'Unknown') as spouse_name FROM artist ar
  LEFT JOIN artist_details ad ON ar.id = ad.artist_id
  JOIN song s ON ar.id = s.artist_id
  LEFT JOIN songs_genres sg ON s.id = sg.song_id
  LEFT JOIN genre g ON g.id = sg.genre_id
  WHERE ar.id = v_artist_id AND g.name = genre_name;
  
END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM return_all_rock_songs_by_artist_with_details(1, 'Rock');
DROP FUNCTION return_all_rock_songs_by_artist_with_details(integer,character varying);
-- • Create a function that returns the quantity of songs for a given album ID, only if the quantity is bigger than 5. If it is not, raise a notice. Use the if/else statement.
CREATE OR REPLACE FUNCTION return_quantity_of_songs_by_album(v_album_id INT)
RETURNS INT
AS $$
DECLARE 
		quantity_of_songs INT;
 BEGIN
	SELECT  COUNT(s.id) INTO quantity_of_songs FROM album al 
	LEFT JOIN song s ON al.id = s.album_id
	WHERE al.id = v_album_id;
-- 	HAVING COUNT(s.id)>5;
	IF quantity_of_songs >= 5 THEN
		RETURN quantity_of_songs;
	ELSE
		RAISE NOTICE 'The album has less or equal to 5 songs';
	END IF;
	
 END;
$$ LANGUAGE PLPGSQL;
--id: 22=9 ,id: 4=11
SELECT * FROM return_quantity_of_songs_by_album(22);
DROP FUNCTION return_quantity_of_songs_by_album(integer);
-- • Create a function that returns all artists that sang a song from a playlist with a certain id.
CREATE OR REPLACE FUNCTION return_all_song_sang_within_playlist(v_artist_id INT)
RETURNS TABLE(
	song_name TEXT,
	playlist_title VARCHAR
) AS $$
 BEGIN
  RETURN QUERY
	SELECT STRING_AGG(s.name,' / ') as song_name, pl.title as playlist_title FROM playlist pl 
	LEFT JOIN playlists_songs ps ON pl.id = ps.playlist_id
	LEFT JOIN song s ON s.id = ps.song_id
	JOIN artist ar ON ar.id = s.artist_id
	WHERE v_artist_id = ar.id
	GROUP BY pl.title;
 END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM return_all_song_sang_within_playlist(1)