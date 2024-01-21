DROP TABLE IF EXISTS project;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS course_project;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS evaluators;
DROP TABLE IF EXISTS achievement;
DROP TABLE IF EXISTS background_materials;

CREATE TABLE background_materials (
    background_id INT PRIMARY KEY,
    background_title VARCHAR(50),
    background_link VARCHAR(150));

CREATE TABLE project (
    project_id INT PRIMARY KEY,
    project_title VARCHAR(100),
    project_category VARCHAR(50),
    project_type VARCHAR(100),
    background_id INT,
    FOREIGN KEY (background_id) REFERENCES background_materials(background_id));

CREATE TABLE course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    course_description VARCHAR(100));

CREATE TABLE course_project (
    course_id INT,
    project_id INT,
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (project_id) REFERENCES project(project_id),
    PRIMARY KEY (course_id, project_id));

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    nickname VARCHAR(20),
    date_of_joining DATE,
    residence VARCHAR(200),
    hobby VARCHAR(50), 
    email VARCHAR(100), 
    course_id INT, FOREIGN KEY (course_id) REFERENCES course(course_id));

CREATE TABLE achievement (
    achievement_id INT PRIMARY KEY,
    student_id INT, FOREIGN KEY (student_id) REFERENCES student(student_id),
    project_id INT, FOREIGN KEY (project_id) REFERENCES project(project_id),
    evaluator_id INT, FOREIGN KEY (evaluator_id) REFERENCES student(student_id),
    evaluaton_date DATE,
    score INT,
    evaluator_comments VARCHAR (300));
