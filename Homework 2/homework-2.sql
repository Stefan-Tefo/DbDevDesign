-- • Show all details for artists born before 01-04-1992
SELECT ad.full_name, ad.date_of_birth FROM artist_details ad
WHERE date_of_birth <= '01.04.1992'
GROUP BY ad.full_name, ad.date_of_birth;
-- • Show all details for artists from Germany
SELECT ad.full_name , ad.country FROM artist_details ad
WHERE country = 'Germany'
GROUP BY ad.full_name , ad.country;
-- • Show all songs longer than 4 minutes
SELECT s.name , s.duration FROM song s
WHERE duration >= '4 minute'
GROUP BY s.name , s.duration;
-- • Show all explicit songs
SELECT s.name, s.explicit FROM song s
WHERE explicit = true
GROUP BY s.name, s.explicit;
-- • Show all genres having ‘o’ in the name
SELECT * FROM genre g
WHERE name ILIKE '%o%';
-- • Show all lyrics having the word ‘that’
SELECT * FROM song_lyrics
WHERE lyrics ILIKE '% that %';
-- • Show all details from artists that have ‘e’ in their full name, ordered by date of birth by the oldest one to the youngest one
SELECT ad.full_name, ad.date_of_birth  FROM artist_details ad
WHERE full_name ILIKE '%e%' 
GROUP BY ad.full_name, ad.date_of_birth
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
-- • List all artist names and artist full names with duplicates
-- • List all common artist names and artist full names
-- • Show all album names and it’s rating
-- • Show all artists with their name and full name side by side
-- • Show all songs with their lyrics side by side
-- • Show artist names with album names side by side
-- • Show the artist names and their spouse name for all artists including ones that don’t have details
-- • Show artist names and list of countries for all, including missing artist and missing details info
-- • List all song names with genre names
-- • List all song names with playlist names
-- • List all album names and rating that have rating above 4 with the artist name
-- • List all explicit song names and artist names without missing data