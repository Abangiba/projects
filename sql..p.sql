SELECT * FROM project.dataset1;
SELECT * FROM project.dataset2;
SELECT  COUNT(*) FROM project.dataset1;
SELECT  COUNT(*) FROM project.dataset2;
SELECT * FROM project.dataset1 WHERE state IN('Jharkhand', 'BIhar');
SELECT SUM(population) FROM project.dataset2;
SELECT AVG(growth) FROM project.dataset1;
# avg_growth
SELECT state, AVG(growth)*100 avg_growth FROM project.dataset1 GROUP BY state;
# sex ratio
SELECT state,ROUND(AVG(sex_ratio),0) avg_sex_ratio FROM project.dataset1 GROUP BY state ORDER BY avg_sex_ratio DESC;
# avg_literacy rate
SELECT state, ROUND(AVG(literacy),0) avg_literacy_ratio FROM project.dataset1 GROUP BY state HAVING ROUND(AVG(literacy),0)>90 ORDER BY avg_literacy_ratio DESC;
# top 3 states with hihest growth ratio
SELECT   state , AVG(growth)*100 avg_growth FROM project.dataset1 GROUP BY state ORDER BY avg_growth DESC LIMIT 3;
# bottom 3 states with the lowest sex ratio
SELECT state,ROUND(AVG(sex_ratio),0)  avg_sex_ratio FROM project.dataset1 GROUP BY state ORDER BY avg_sex_ratio LIMIT 3;
# states with the lowest and highest literacy
DROP TABLE IF EXISTS  topstates;
CREATE table topstates
(state varchar(255),
topstate float 
);
SHOW TABLES LIKE 'topstates';
INSERT INTO topstates
SELECT state,ROUND(AVG(literacy),0)  avg_literacy_ratio  FROM project.dataset1 GROUP BY state ORDER BY avg_literacy_ratio DESC;
SELECT *FROM topstates ORDER BY topstates DESC;
#bottomstate
DROP TABLE IF EXISTS bottomstates;
CREATE TABLE bottomstates
(state VARCHAR(255),
bottomstate float
);
INSERT INTO bottomstates
SELECT state,ROUND(AVG(literacy),0) avg_literacy_ratio FROM project.dataset1
GROUP BY state ORDER BY avg_literacy_ratio;
SELECT * FROM (
SELECT * FROM bottomstates ORDER BY bottomstates ASC LIMIT 3) a
UNION
SELECT * FROM(
 SELECT*  FROM topstates ORDER BY topstates DESC LIMIT 3) b;
# states starting with letter a 
SELECT  DISTINCT state FROM project.dataset1 WHERE lower(state) LIKE 'a%' OR lower(state) LIKE 'b%';
