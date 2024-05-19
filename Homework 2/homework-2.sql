-- • Show all details for artists born before 01-04-1992
SELECT ad.full_name, ad.date_of_birth FROM artist_details ad
WHERE date_of_birth <= '01.04.1992'
-- • Show all details for artists from Germany
SELECT ad.full_name , ad.country FROM artist_details ad
WHERE country = 'Germany'
-- • Show all songs longer than 4 minutes
SELECT s.name , s.duration FROM song s
WHERE duration >= '4 minute'
-- • Show all explicit songs
SELECT s.name, s.explicit FROM song s
WHERE explicit = true
-- • Show all genres having ‘o’ in the name
SELECT * FROM genre g
WHERE name ILIKE '%o%';
-- • Show all lyrics having the word ‘that’
SELECT * FROM song_lyrics
WHERE lyrics ILIKE '% that %';
-- • Show all details from artists that have ‘e’ in their full name, ordered by date of birth by the oldest one to the youngest one
SELECT ad.full_name, ad.date_of_birth  FROM artist_details ad
WHERE full_name ILIKE '%e%' 
ORDER BY date_of_birth ASC;
-- • Show all non-explicit songs sorted by duration from shortest to longest
SELECT * FROM song
WHERE explicit = false
ORDER BY duration ASC;
-- • Show albums that have ‘u’ in their name sorted by rating, with worst rating on top
SELECT * FROM album
WHERE name ILIKE '%u%'
ORDER BY rating ASC;
-- • List all artist names and artist full names without duplicates
SELECT ar.name, ad.full_name FROM artist ar
FULL JOIN artist_details ad ON ad.artist_id = ar.id
ORDER BY name ASC; --samo za proverka
-- • List all artist names and artist full names with duplicates
SELECT ar.name, ad.full_name FROM artist ar
JOIN artist_details ad ON ad.artist_id = ar.id;
-- • List all common artist names and artist full names
SELECT ar.name, ad.full_name FROM artist ar
FULL JOIN artist_details ad ON ad.artist_id = ar.id;
-- • Show all album names and it’s rating
SELECT al.name, al.rating FROM album al;
-- • Show all artists with their name and full name side by side
SELECT ar.name, ad.full_name FROM artist ar
FULL JOIN artist_details ad ON ad.artist_id = ar.id;
-- • Show all songs with their lyrics side by side
SELECT s.name, sl.lyrics FROM song s
FULL JOIN song_lyrics sl ON sl.song_id = s.id;
-- • Show artist names with album names side by side
SELECT ar.name as artist_name, STRING_AGG(al.name,' / ') as album_name FROM artist ar
LEFT JOIN song s ON ar.id = s.artist_id
LEFT JOIN album al ON al.id = s.album_id
GROUP BY ar.name;
-- • Show the artist names and their spouse name for all artists including ones that don’t have details
SELECT a.name, ad.spouse_name FROM artist_details ad
JOIN artist a ON a.id = ad.artist_id ;
-- • Show artist names and list of countries for all, including missing artist and missing details info
SELECT a.name, ad.country FROM artist a
FULL JOIN artist_details ad ON ad.artist_id = a.id;
-- • List all song names with genre names
SELECT s.name as song_name ,STRING_AGG(g.name, ' / ') as genre_name FROM song s
LEFT JOIN songs_genres sg ON sg.song_id = s.id
LEFT JOIN genre g ON g.id = sg.genre_id
GROUP BY s.name;
-- • List all song names with playlist names
SELECT s.name ,p.title FROM song s
LEFT JOIN playlists_songs ps ON ps.song_id = s.id
LEFT JOIN playlist p ON p.id = ps.SONG_id
GROUP BY s.name, p.title;
ORDER BY name ASC -- samo za testiranje
-- • List all album names and rating that have rating above 4 with the artist name
SELECT ar.name as artist_name, al.name album_name, al.rating FROM artist ar
LEFT JOIN song s ON ar.id = s.artist_id
LEFT JOIN album al ON al.id = s.album_id
WHERE al.rating > 4
GROUP BY ar.name, al.name, al.rating;
-- • List all explicit song names and artist names without missing data
SELECT ar.name, s.name, s.explicit  FROM artist ar
JOIN song s ON ar.id = s.artist_id
WHERE s.explicit = true;