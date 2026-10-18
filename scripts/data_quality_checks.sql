/*
Diese Queries testet, ob die Daten ohne weitere Anpassungen benutzt werden können.
Da die Daten sehr gut vorbereitet wurde, fallen hier nicht sonderlich viele Tests an.
Es handelt sich um sehr viele numerischen Werte, weshalb der Fokus auf dem Finden von 
NULLs und nicht auf dem Testen auf falsch eingerückete Daten wie es bei VARCHAR-Werte 
manchmal vorkommt, liegt.
*/



-- testen, ob die IDs auch unique sind (für alle Table)

-- für den absenteeism_at_work Table
SELECT 
ID,
count(*)
FROM Absenteeism_at_work
GROUP BY ID
HAVING count(*) > 1

-- für den compensation Table
SELECT 
ID,
count(*)
FROM compensation
GROUP BY ID
HAVING count(*) > 1

-- für den reasons Table
SELECT 
Number,
count(*)
FROM Reasons
GROUP BY Number
HAVING count(*) > 1

-- auf NULLs un auf einheitliche Werte in den Daten testen 
-- (jeweils einzelne Table und jeweiligen Spalten einsetzen)
SELECT DISTINCT 
Reason_for_absence
FROM Absenteeism_at_work
