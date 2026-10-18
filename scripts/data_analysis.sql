/*
Diese Queries bieten den ersten Einblick in die Daten und stellen die Merkmale 
zusammen, die im Folgenden in Power BI verwendet werden.
*/

-------------------------------------------------------------------------------------
-- grundlegendes Joinen der Table
SELECT * 
FROM Absenteeism_at_work AS a
LEFT JOIN compensation AS c
ON a.ID = c.ID
LEFT JOIN Reasons AS r
ON a.Reason_for_absence = r.Number

	
-- die gesündesten Mitarbeiter finden
SELECT * 
FROM Absenteeism_at_work
WHERE Social_drinker = 0 AND Social_smoker = 0
AND Body_mass_index < 25 
AND Absenteeism_time_in_hours <
(SELECT 
AVG(Absenteeism_time_in_hours)
FROM Absenteeism_at_work
)

	
-- Erhöhung des Vergütungssatzes für Nichtraucher 
-- Budget = 983.221€ -- 686 Mitarbeiter
-- Arbeitstunden pro Jahr: 5 Wochentage x 8 Stunden x 52 Wochen pro Jahr
-- = 2080 Stunden pro Jahr pro Mitarbeiter
-- Insgesamt werden alo 2080 x 686 = 1.426.880 Stunden gearbeitet
-- 983.221€ / 1.426.880h = 0,689€/h -- also ca. 69 Cent mehr pro Stunde
SELECT 
COUNT(*) AS non_smokers
FROM Absenteeism_at_work
WHERE Social_smoker = 0

	
-- optimieren der ersten Join-Query durch das Auswählen der Spalten die 
-- wirklich benötigt werden
SELECT
a.ID,
r.Reason,
a.Body_mass_index,
CASE WHEN Body_mass_index < 18.5 THEN 'Underweight'
	 WHEN Body_mass_index BETWEEN 18.5 AND 25 THEN 'Healty'
	 WHEN Body_mass_index BETWEEN 25 AND 30 THEN 'Underweight'
	 WHEN Body_mass_index > 30 THEN 'Obese'
	 ELSE 'Unkown'
END AS bmi_category,
a.Month_of_absence,
CASE WHEN Month_of_absence IN (12,1,2) THEN 'Winter'
	 WHEN Month_of_absence IN (3,4,5) THEN 'Spring'
	 WHEN Month_of_absence IN (6,7,8) THEN 'Summer'
	 WHEN Month_of_absence IN (9,10,11) THEN 'Autumn'
	 ELSE 'Unkown'
END AS season_names,
Seasons,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Social_drinker
Social_smoker,
Pet,
Disciplinary_failure,
Age,
Work_load_Average_day,
Absenteeism_time_in_hours
FROM Absenteeism_at_work AS a
LEFT JOIN compensation AS c
ON a.ID = c.ID
LEFT JOIN Reasons AS r
ON a.Reason_for_absence = r.Number
