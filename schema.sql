Users
name
surname
team
position
phone
rental_count
overdue_count

Media

LoanHistory

1.
SELECT * FROM Users WHERE id=$id;
UPDATE Users WHERE id=$id SET field=$value;

2.
2.1
SELECT title, type, year, producer, location, availability FROM Movies WHERE title LIKE %$title%;

2.2
SELECT title, type, year, producer, location, availability FROM Movies WHERE title LIKE %$title% WHERE year = $year AND availability = $availability;

2.3
SELECT title, type, year, producer, location, availability FROM Movies WHERE title LIKE %$title% WHERE year = $year AND availability = $availability AND language = $language;

2.4
SELECT title, type, year, producer, location, availability, cast FROM Movies WHERE cast IN ($cast);

3.
3.1
# Overdue should be calculated in the app itself and not in the database.
SELECT title, year, rent_start, rent_effective FROM LoanHistory, Media WHERE LoanHistory.user_id = $user_id [ORDER BY title, rent_start, rent_effective];

3.2
SELECT title, year, rent_start, rent_effective FROM LoanHistory, Media WHERE LoanHistory.user_id = $user_id AND rent_effective IS [NOT] NULL [ORDER BY title, rent_start, rent_effective];

4.
4.1
SELECT * FROM Users 
# Optional filters
WHERE name = $name AND surname = $surname AND team = $team AND language = $language ORDER BY name, surname, age;

4.2
SELECT Users.name, Users.surname, Users.phone, Media.title, Media.type, LoanHistory.rent_start, LoanHistory.rent_expected, CURRENT_DATE() - LoanHistory.rent_start AS overdue 
FROM Users, Media, LoanHistory
WHERE Users.id = LoanHistory.user_id AND Media.id = LoanHistory.media_id 
# Optional filters
AND rent_effective IS NULL AND name = $name AND title = $title ORDER BY rent_start, rent_estimated, overdue;

4.3
SELECT name, surname, team, position, rental_count From Users WHERE name LIKE %$name% ORDER BY rental_count DESC;

4.4
SELECT name, surname, team, position, phone, overdue_count From Users WHERE name LIKE %$name% ORDER BY overdue_count DESC;

5
5.1
UPDATE Media SET availability = 1, location = $location WHERE id = $media_id;

5.2
UPDATE Users SET overdue_count = 0 WHERE id = $user_id;
# Mention that we may need to reset the rental_effective > rental_estimated records to cover our tracks. ;)





=============================
# New Rental
START TRANSACTION;
INSERT INTO LoanHistory () VALUES ();
UPDATE Users SET rental_count = rental_count + 1 WHERE user_id = $user_id
UPDATE Media SET availability = 0 WHERE id = $media_id;
COMMIT;
# On error:
ROLLBACK;

# New Return
UPDATE LoanHistory SET rent_effective = CURRENT_DATE() WHERE id = 1;
# If rent_effective date is past rent_estimated (make sure to use transaction!)
    UPDATE Users SET overdue_count = overdue_count + 1 WHERE user_id = $user_id;

UPDATE Media SET availability = 1 WHERE id = $media_id;
