INSERT INTO background_materials VALUES
(1, 'Microsoft', 'https://support.microsoft.com/en-au/office/excel-video-training-9bc05390-e94c-46af-a5b3-d7c22f6990bb'),
(2, 'W3 Schools', 'https://www.w3schools.com/'),
(3, 'freeCodeCamp', 'https://www.freecodecamp.org/'),
(4, 'Programiz', 'https://www.programiz.com/javascript/examples'),
(5, 'Atlassian', 'https://www.atlassian.com/');

INSERT INTO project VALUES
(1, 'Excel', 'Tutorial', 'Team', 1),
(2, 'SQL', 'Exercise', 'Solo', 2),
(3, 'Python', 'Exercise', 'Team', 3),
(4, 'CSS', 'Tutorial', 'Solo', 2),
(5, 'Javascript', 'Tutorial', 'Team',4),
(6, 'Teamwork', 'Exercise', 'Team', 5);

INSERT INTO course VALUES
(1, 'Data analyst', 'Become a data analyst'),
(2, 'Cybersecurity', 'Get to know cybersecurity'),
(3, 'Web design', 'Design a page');

INSERT INTO course_project VALUES
(1,1), (1,2), (1,3), (1,6),
(2,2), (2,3), (2,5), (2,6),
(3,3), (3,4), (3,5), (3,6);

INSERT INTO student VALUES
(1, 'Donat B', 'Doni', '2023-06-01', 'Hungary', 'pottery', 'donat@donat.com', 1),
(2, 'Timi K', 'Timi', '2023-07-01', 'Italy', 'motorcycling', 'timi@timi.com', 2),
(3, 'Gergely F', 'Geri', '2023-06-15', 'Hungary', 'fencing', 'geri@geri.com', 3),
(4, 'Gabor B', 'Gabi', '2023-07-15', 'Hungary', 'tarot', 'gabi@gabi.com', 1),
(5, 'Tamas H', 'Tomi', '2023-06-01', 'Hungary', 'scuba diving', 'tomi@tomi.com', 2),
(6, 'Emoke Frei', 'Mimi', '2023-06-01', 'UK', 'surfing', 'mimi@mimi.com', 3),
(7, 'Marcell F', 'Marci', '2023-07-01', 'Hungary', 'karaoke', 'marci@marci.com', 1),
(8, 'Zsombor Sz', 'Zsombi', '2023-06-15', 'Hungary', 'pilates', 'zsombor@zsombor.com', 2),
(9, 'Szabolcs Sz', 'Szabi', '2023-07-15', 'Hungary', 'kite flying', 'szabi@szabi.com', 3),
(10, 'Bence T', 'Benci', '2023-06-01', 'Hungary', 'egyptology', 'bence@bence.com', 1);

INSERT INTO achievement VALUES
(1,1,1,2,'2023-06-27',2,'fulfilled criteria'),
(2,1,2,3,'2023-06-27',3,'ok'),
(3,1,3,4,'2023-06-27',4,'good'),
(4,1,6,5,'2023-06-27',4,'very good'),
(5,2,2,6,'2023-06-27',2,'fulfilled criteria'),
(6,2,3,7,'2023-06-12',3,'missing some criteria'),
(7,2,5,8,'2023-06-12',4,'nice work'),
(8,2,6,9,'2023-06-12',5,'well done'),
(9,3,3,10,'2023-06-12',2,'pass'),
(10,3,4,1,'2023-06-07',2,'okay'),
(11,3,5,2,'2023-06-07',4,'good job'),
(12,3,6,4,'2023-06-07',2,'perfetto'),
(13,4,1,5,'2023-06-07',2,'acceptable'),
(14,4,3,6,'2023-06-20',3,'fine'),
(15,4,3,7,'2023-06-20',4,'good job'),
(16,4,6,8,'2023-06-20',5,'very good'),
(17,5,2,9,'2023-06-20',2,'ok'),
(18,5,3,10,'2023-06-20',3,'ok'),
(19,5,5,1,'2023-06-20',4,'good job'),
(20,5,6,2,'2023-06-20',5,'very good'),
(21,6,3,3,'2023-06-23',2,'pass'),
(22,6,4,4,'2023-06-23',5,'acceptable'),
(23,6,5,5,'2023-06-23',4,'nice work'),
(24,6,6,7,'2023-06-23',5,'perfect'),
(25,7,3,10,'2023-06-23',2,'pass'),
(26,7,2,9,'2023-06-23',5,'nicely done'),
(27,7,3,10,'2023-06-24',4,'very good'),
(28,7,6,1,'2023-06-24',5,'very good'),
(29,8,2,2,'2023-06-24',2,'acceptable'),
(30,8,3,3,'2023-06-24',3,'not bad'),
(31,8,5,4,'2023-06-24',3,'nice work'),
(32,8,6,5,'2023-06-24',5,'very well done'),
(33,9,6,10,'2023-06-24',2,'just passed'),
(34,9,4,7,'2023-06-24',5,'okay'),
(35,9,5,8,'2023-06-19',2,'nice job'),
(36,9,6,10,'2023-06-19',5,'very good'),
(37,10,1,1,'2023-06-19',2,'okay'),
(38,10,2,2,'2023-06-19',4,'not too bad'),
(39,10,3,3,'2023-06-19',5,'fine'),
(40,10,6,4,'2023-06-19',5,'very good job'),
(41,3,2,10,'2023-06-27',4,'pretty good');

SELECT * FROM background_materials;
SELECT * FROM project;
SELECT * FROM course;
SELECT * FROM course_project;
SELECT * FROM student;
SELECT * FROM achievement;