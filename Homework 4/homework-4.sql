-- • Calculate rating of album by artist
	SELECT ar.name as artist_name, al.name as album_name, COUNT(al.rating) FROM artist ar
	LEFT JOIN song s ON ar.id = s.artist_id
	LEFT JOIN album al ON al.id = s.album_id
	GROUP BY ar.name, al.name;
-- • Get longest song by genre
	SELECT g.name,MAX(s.duration) FROM song s
	JOIN songs_genres sg ON s.id = sg.song_id
	LEFT JOIN genre g ON g.id = sg.genre_id
	GROUP BY g.name;
-- • Create text like "<Artist_Name> best rated album is <Name_of_album>”
CREATE OR REPLACE FUNCTION artist_name_plus_name_of_album()
RETURNS TABLE(
 full_sentance TEXT
) AS $$
 BEGIN
	RETURN QUERY
	SELECT CONCAT(ar.name,' best rated album ', MAX(al.rating)) FROM artist ar
	LEFT JOIN song s ON ar.id = s.artist_id
	LEFT JOIN album al ON al.id = s.album_id
	GROUP BY ar.name;
 END;
$$ LANGUAGE PLPGSQL;

--DROP FUNCTION artist_name_plus_name_of_album(); za ne daj boze :)
SELECT artist_name_plus_name_of_album();
-- • Create a temp table with playlist that has songs which are in albums which are good rated (4.5+ rating)
CREATE TEMP TABLE temp_playlist_songs_albums_good_rated AS
SELECT al.name, pl.title FROM album al
LEFT JOIN song s ON al.id= s.album_id
LEFT JOIN playlists_songs ps ON s.id = ps.song_id
JOIN playlist pl ON pl.id = ps.playlist_id 
WHERE al.rating > 4.5
GROUP BY al.name,pl.title;

SELECT * FROM temp_playlist_songs_albums_good_rated;
-- • Create a function that will provide artist name, concatenated genre names he has songs in.
CREATE OR REPLACE FUNCTION get_all_artist_with_all_there_genres()
RETURNS TABLE(
 full_request TEXT
) AS $$
BEGIN
RETURN QUERY
	SELECT CONCAT(ar.name, ' - ', STRING_AGG(g.name, ' / ')) as artist_genre_name FROM artist ar
	JOIN song s ON s.artist_id = ar.id
	LEFT JOIN songs_genres sg ON s.id = sg.song_id
	LEFT JOIN genre g ON g.id = sg.genre_id
	GROUP BY ar.name;
END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM get_all_artist_with_all_there_genres();
-- • Create a function that will provide: Number of songs per album, number of songs per playlist, number of songs per genre
CREATE OR REPLACE FUNCTION get_all_number_of_songs_albums_playlist_per_something()
RETURNS INT
AS $$
DECLARE
	songs_per_album INT;
	songs_per_playlist INT;
	songs_per_genres INT;
BEGIN
	SELECT al.name, COUNT(s.id) INTO songs_per_album FROM song s
	JOIN album al ON al.id = s.album_id
	GROUP BY al.name;
	
	SELECT pl.title, COUNT(s.id) INTO songs_per_playlist FROM song s
	LEFT JOIN playlists_songs ps ON s.id = ps.song_id
	JOIN playlist pl ON pl.id = ps.playlist_id
	GROUP BY pl.title;
	
	SELECT g.name, COUNT(s.id) INTO songs_per_genres FROM song s
	LEFT JOIN songs_genres sg ON s.id = sg.song_id
	JOIN genre g ON g.id = sg.genre_id
	GROUP BY g.name;
	
	-- OVA MI E VTORA IDEA NO VRAKA SEGDE VREDNOSI OD 1 :) ILI TREBA POSEBNI TRI FUNKCII
-- 	SELECT al.name, COUNT(s.id) as songs_per_album,pl.title, COUNT(s.id) as songs_per_playlist, g.name, COUNT(s.id) as songs_per_genres  FROM album al
-- 	JOIN song s ON al.id = s.album_id
-- 	LEFT JOIN playlists_songs ps ON s.id = ps.song_id
-- 	JOIN playlist pl ON pl.id = ps.playlist_id
-- 	LEFT JOIN songs_genres sg ON s.id = sg.song_id
-- 	JOIN genre g ON g.id = sg.genre_id
-- 	GROUP BY al.name,pl.title ,g.name;

	
	RETURN songs_per_genres, songs_per_playlist, songs_per_album;
END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM get_all_number_of_songs_albums_playlist_per_something();
-- MI GO DAVA OVOJ ERROR:  invalid input syntax for type integer: "Cloud Nine"
-- CONTEXT:  PL/pgSQL function get_all_number_of_songs_albums_playlist_per_something() line 7 at SQL statement 
DROP FUNCTION get_all_number_of_songs_albums_playlist_per_something();