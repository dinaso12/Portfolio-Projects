UPDATE background_materials 
SET background_link = 'https://www.atlassian.com/git/glossary' 
    WHERE background_title = 'Atlassian';

DELETE FROM achievement
    WHERE student_id = (SELECT student_id FROM student WHERE student_name = 'Gergely F') 
    AND project_id = (SELECT project_id FROM project WHERE project_title = 'SQL');

UPDATE achievement
SET score = 4 
    WHERE score = 3 
    AND project_id = (SELECT project_id FROM project WHERE project_title = 'SQL');

UPDATE course
SET course_description = 'Create sitemap, design prototype and build site'
    WHERE course_name = 'Web design';