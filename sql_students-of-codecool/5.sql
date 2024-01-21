--Exercises and other projects are listed by courses
SELECT project_title, 
    project_category,
    STRING_AGG(course_name, ', ') AS course_name
FROM course_project
INNER JOIN course USING (course_id)
INNER JOIN project USING (project_id)
GROUP BY project_title, project_category;

--Individual projects with all related elements are listed
SELECT student_name, 
    project_title, 
    project_category, 
    project_type, 
    score, 
    background_title FROM achievement
INNER JOIN project USING (project_id)
INNER JOIN student USING (student_id)
INNER JOIN background_materials ON project.background_id = background_materials.background_id
ORDER BY student_name ASC;

--Students are listed by courses
SELECT student_name,
    course_name,
    course_description FROM student
INNER JOIN course USING (course_id);

--The students' achievements per project, based on their results, 
--including all the details of the evaluation
SELECT a.student_name AS student, 
    project_title,
    b.student_name AS evaluator,
    evaluaton_date,
    score,
    evaluator_comments FROM achievement
INNER JOIN student a ON achievement.student_id = a.student_id
INNER JOIN student b ON achievement.evaluator_id = b.student_id
INNER JOIN project USING (project_id);

--Aggregated result of the students' performance. The survey should calculate 
--an average of the scores achieved and if the student scored above 60%, 
--he would receive an "advanced" rating, if below, he would be "considered advanced".
SELECT student_name,
    ROUND(AVG(score),2),
    CASE
        WHEN AVG(score) > 5*0.6
            THEN 'Advanced'
        ELSE 'considered advanced' 
    END AS rating 
    FROM achievement
INNER JOIN student USING (student_id)
GROUP BY student_name;

--List of the 3 best performing students based on their cumulative (not average) scores.
SELECT student_name,
    sum(score)
FROM achievement
INNER JOIN student USING (student_id)
GROUP BY student_name
ORDER BY sum(score) DESC LIMIT 3;