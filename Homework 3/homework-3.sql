-- • Calculate the count of all songs in the system
SELECT COUNT(s.id) FROM song s;
-- • Calculate the count of all songs per artist in the system
SELECT ar.name , COUNT(s.id) as song_per_arrtist FROM artist ar
LEFT JOIN song s ON ar.id = s.artist_id
GROUP BY ar.name;
-- • Calculate the count of all songs per artist in the system for first 100 albums (ID < 100)
SELECT al.name album_name, COUNT(s.id) as song_per_arrtist FROM artist ar
LEFT JOIN song s ON ar.id = s.artist_id
LEFT JOIN album al ON al.id = s.album_id
WHERE al.id < 10
GROUP BY al.name
-- HAVING COUNT(al.id) < 100; ova mi e vo razmisluvanje
-- • Find the maximal duration and the average duration per song for each artist
SELECT ar.name as artist_name, SUM(s.duration), s.name as song_name ,AVG(s.duration) FROM artist ar
LEFT JOIN song s ON ar.id = s.artist_id
GROUP BY ar.name,s.name;
-- • Calculate the count of all songs per artist in the system and filter only song count greater than 10
SELECT ar.name , COUNT(s.id) as song_per_arrtist FROM artist ar
LEFT JOIN song s ON ar.id = s.artist_id
GROUP BY ar.name
HAVING COUNT(s.id)>10;
-- • Calculate the count of all songs per artist in the system for first 100 albums (ID < 100) and filter artists with more than 10 song count
SELECT al.name album_name, COUNT(s.id) as song_per_arrtist FROM artist ar
LEFT JOIN song s ON ar.id = s.artist_id
LEFT JOIN album al ON al.id = s.album_id
WHERE al.id < 100
GROUP BY al.name
HAVING COUNT(s.id)>10;
-- • Find the song count, maximal duration, and the average duration per artist on all songs in the system. Filter only records where maximal duration is more than the average duration
SELECT ar.name as artist_name,COUNT(s.id) as song_per_arrtist ,SUM(s.duration), s.name as song_name ,AVG(s.duration) FROM artist ar
LEFT JOIN song s ON ar.id = s.artist_id
GROUP BY ar.name,s.name
HAVING SUM(s.duration)>AVG(s.duration);
-- • Create a new view (vw_ArtistSongCounts) that will list all artist IDs and count of songs per artist
-- • Change the view to show artist names instead of artist ID
-- • List all rows from the view ordered by the biggest song count
-- • Create a new view (vw_ArtistAlbumDetails) that will list all artists (name) and count the albums they have