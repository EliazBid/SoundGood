--query one
SELECT 
    EXTRACT(YEAR FROM lesson.time_slot) AS Year,
	EXTRACT(MONTH FROM lesson.time_slot) AS Month,
	COUNT(*) as TOTAL,
	COUNT(CASE WHEN individual_lesson.lesson_id IS NOT NULL THEN 1 END) AS Individual,
    COUNT(CASE WHEN group_lesson.lesson_id IS NOT NULL THEN 1 END) AS Group, 
	COUNT(CASE WHEN ensemble.lesson_id IS NOT NULL THEN 1 END) AS Ensemble
From lesson
LEFT JOIN ensemble
    ON lesson.id = ensemble.lesson_id
LEFT JOIN group_lesson
    ON lesson.id = group_lesson.lesson_id
LEFT JOIN individual_lesson
    ON lesson.id = individual_lesson.lesson_id
WHERE 
	EXTRACT(YEAR FROM lesson.time_slot) = 2023 -- change for specified year
	AND 
	(lesson.id = ensemble.lesson_id 
	 OR 
	 lesson.id = group_lesson.lesson_id 
	 OR 
	 lesson.id = individual_lesson.lesson_id)
GROUP BY
    YEAR,
	MONTH;

--view for query one, year to look at must be specified by WHERE outside view, data only creates lessons in 2023 though 
CREATE VIEW lessons_per_month AS 
SELECT 
    EXTRACT(YEAR FROM lesson.time_slot) AS Year,
	EXTRACT(MONTH FROM lesson.time_slot) AS Month,
	COUNT(*) as TOTAL,
	COUNT(CASE WHEN ensemble.lesson_id IS NOT NULL THEN 1 END) AS Ensemble,
    COUNT(CASE WHEN group_lesson.lesson_id IS NOT NULL THEN 1 END) AS Group, 
    COUNT(CASE WHEN individual_lesson.lesson_id IS NOT NULL THEN 1 END) AS Indiviual
From lesson
LEFT JOIN ensemble
    ON lesson.id = ensemble.lesson_id
LEFT JOIN group_lesson
    ON lesson.id = group_lesson.lesson_id
LEFT JOIN individual_lesson
    ON lesson.id = individual_lesson.lesson_id
WHERE 
	(lesson.id = ensemble.lesson_id 
	 OR 
	 lesson.id = group_lesson.lesson_id 
	 OR 
	 lesson.id = individual_lesson.lesson_id)
GROUP BY
    YEAR,
	MONTH;


--query two
SELECT 
	num_siblings,
	COUNT(*) AS studentsWithSibling
FROM
	(SELECT 
	student_id, 
	COUNT(*) AS num_siblings
	FROM sibling
	GROUP BY student_id)
	GROUP BY num_siblings

UNION
    SELECT 
        0 AS num_siblings,
        COUNT(*) AS studentWithSibling
    FROM
        (SELECT student.id
        FROM student 
        LEFT JOIN sibling ON student.id = sibling.student_id
        WHERE sibling.student_id IS NULL) 
GROUP BY num_siblings
ORDER BY num_siblings ASC;

--view for query two, materialized since we assume we don't often write to change sibling table
CREATE MATERIALIZED VIEW sibling_count AS
SELECT 
	num_siblings,
	COUNT(*) AS studentsWithSibling
FROM
	(SELECT 
	student_id, 
	COUNT(*) AS num_siblings
	FROM sibling
	GROUP BY student_id)
	GROUP BY num_siblings

UNION
    SELECT 
        0 AS num_siblings,
        COUNT(*) AS studentWithSibling
    FROM
        (SELECT student.id
        FROM student 
        LEFT JOIN sibling ON student.id = sibling.student_id
        WHERE sibling.student_id IS NULL) 
GROUP BY num_siblings
ORDER BY num_siblings ASC;


--query three
SELECT EXTRACT(MONTH FROM lesson.time_slot) AS month,instructor.id, person.first_name, person.last_name, COUNT(lesson.id) AS lesson_count
FROM person
LEFT JOIN instructor
    ON person.id = instructor.person_id
LEFT JOIN lesson
    ON instructor.id = lesson.instructor_id
GROUP BY
    instructor.id, person.first_name, person.last_name, EXTRACT(MONTH FROM lesson.time_slot)
HAVING
    COUNT(lesson.id) > 0 AND EXTRACT(MONTH FROM lesson.time_slot) = 11; --change for specified month

--view for query three, month to look at must be specified outside view
CREATE VIEW instructor_work AS
SELECT EXTRACT(MONTH FROM lesson.time_slot) AS month,instructor.id, person.first_name, person.last_name, COUNT(lesson.id) AS lesson_count
FROM person
LEFT JOIN instructor
    ON person.id = instructor.person_id
LEFT JOIN lesson
    ON instructor.id = lesson.instructor_id
GROUP BY
    instructor.id, person.first_name, person.last_name, EXTRACT(MONTH FROM lesson.time_slot)
HAVING
    COUNT(lesson.id) > 0;

--query four
SELECT
    EXTRACT (DAY FROM lesson.time_slot) AS Day,
    ensemble.target_genre AS Genre,
    CASE 
        WHEN (SELECT COUNT(*) FROM student_lesson sl WHERE sl.lesson_id = ensemble.lesson_id) >= ensemble.maximum_enrollment THEN 'No Seats'
        WHEN (SELECT COUNT(*) FROM student_lesson sl WHERE sl.lesson_id = ensemble.lesson_id) = ensemble.maximum_enrollment-1 OR 
        (SELECT COUNT(*) FROM student_lesson sl WHERE sl.lesson_id = ensemble.lesson_id) = ensemble.maximum_enrollment-2 THEN '1 or 2 Seats Left'

        ELSE 'Many Seats'
    END AS Enrollment_Status
FROM 
    lesson
JOIN
    ensemble ON lesson.id = ensemble.lesson_id
WHERE
    EXTRACT(WEEK FROM lesson.time_slot) = 52; --week 52 has one unbooked and one with two seats left, also one fully booked
