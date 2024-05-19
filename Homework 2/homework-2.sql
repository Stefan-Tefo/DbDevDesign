SELECT ad.full_name, ad.date_of_birth FROM artist_details ad
WHERE date_of_birth <= '01.04.1992'
GROUP BY ad.full_name, ad.date_of_birth;

SELECT ad.full_name , ad.country FROM artist_details ad
WHERE country = 'Germany'
GROUP BY ad.full_name , ad.country;

SELECT s.name , s.duration FROM song s
WHERE duration >= '4 minute'
GROUP BY s.name , s.duration