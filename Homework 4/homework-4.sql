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
) AS
$$
BEGIN
RETURN QUERY
 SELECT CONCAT(ar.name,' best rated album ', MAX(al.rating)) FROM artist ar
 LEFT JOIN song s ON ar.id = s.artist_id
 LEFT JOIN album al ON al.id = s.album_id
 GROUP BY ar.name;
END;
$$ LANGUAGE PLPGSQL;

DROP FUNCTION artist_name_plus_name_of_album();
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