[Tableau project_heart failures](https://public.tableau.com/views/heartfailuresdashboard/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link)

[tableau project](https://public.tableau.com/shared/S36B22934?:display_count=n&:origin=viz_share_link) 

[tableau project](https://public.tableau.com/views/housedata_16941430025890/KingCountyHouseSales?:language=en-US&:display_count=n&:origin=viz_share_link)

[tableau project](https://public.tableau.com/views/KingCountyHouseSale_16942719868200/KingCountyHouseSales?:language=en-US&:display_count=n&:origin=viz_share_link)

[tableau project](https://public.tableau.com/views/Book1_16929013760850/salesdashboard?:language=en-US&:display_count=n&:origin=viz_share_link)




use hrdata;
SELECT * FROM hrdata.hr;
ALTER TABLE hr 
CHANGE COLUMN id emp_id VARCHAR(20) NULL;

DESCRIBE hr;
SELECT birthdate from hr;
SELECT DATE_FORMAT (birthdate,'%M/%d/%Y') FROM hr;

SELECT hire_date from hr;
SELECT DATE_FORMAT (hire_date,'%M/%d/%Y') FROM hr;
UPDATE hr
SET hire_date = DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d');



SELECT str_to_date(hire_date,'%m/%d/%y') from hr;

SELECT str_to_date(birthdate,'%m/%d/%y') from hr;
UPDATE hr
SET birthdate = STR_TO_DATE( birthdate,'%m/%d/%y');

UPDATE hr
SET birthdate = DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d');

ALTER TABLE hr 
MODIFY COLUMN birthdate DATE;
DESCRIBE hr;

ALTER TABLE hr 
MODIFY COLUMN hire_date DATE;
DESCRIBE hr;

SET sql_safe_updates = 0;

select termdate from hr;
update hr 
SET termdate = DATE(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
WHERE  termdate IS NOT NULL AND termdate!='';

UPDATE  hr
SET termdate =  NOT NULL
WHERE termdate ='';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

SELECT birthdate,age  FROM hr;
ALTER TABLE hr ADD COLUMN age INT ;

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR,birthdate,CURDATE());

SELECT 
MIN(age) AS youngest,
MAX(age) AS oldest
FROM hr;

##### QUESTIONS 
###### 1. what is the gender breakdown of employees in the company?

select *from hrdata. hr;

SELECT gender,count(*) AS count
FROM hr  
WHERE termdate is NULL
GROUP BY gender;

#### what is the race breakdown of employees in the company?
SELECT  race, COUNT(*) AS count
FROM hr
WHERE termdate is NULL
GROUP BY race;

#### what is the age distribution of employees in the company?
SELECT 
	CASE 
		  WHEN age >=18 AND age <=24 THEN '18-24'
          WHEN age >=25 AND age <=35 THEN  '25-34'
          WHEN age >=35 AND   age <=44 THEN  '35-44'
          WHEN age >=45 AND   age <=54 THEN  '45-54'
          WHEN age >=55 AND   age <=64 THEN  '55-64'
          ELSE '64+'
  END AS age_group, 
	COUNT(*) AS count
    FROM hr
    WHERE termdate IS null
    GROUP BY age_group 
    ORDER BY age_group;
    
    ###How many employees work HQ vs remote
    SELECT  location ,COUNT(*) AS count
    FROM hr
    WHERE termdate IS NULL
    GROUP BY location;
    
    ### What is the average term of employees who have been terminated
    SELECT  ROUND(AVG(YEAR(termdate)-YEAR(hire_date)),0) AS length_emp
    FROM hr
    WHERE termdate IS NOT NUll AND termdate <= curdate();
    ### How does the gender distribution vary accross dept and job titles
    select * from hr;
    SELECT department,jobtitle,gender,count(*)
    FROM hr
    WHERE termdate IS NOT NULL
    GROUP BY department,jobtitle,gender
    ORDER BY department,jobtitle,gender;
    ### What is the distribution of jobtitles across the company
    SELECT jobtitle ,count(*) AS count
    
    FROM hr
    WHERE termdate IS  NULL
    GROUP BY jobtitle;
    
    ## Which dept has thehighest turnover/termination rate
    
    SELECT department,
             count(*) AS total_count,
			  count(CASE 
                        WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
                        END) AS terminated_count,
			   ROUND((count( CASE 
                        WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
                        END)/count(*))*100,2) AS termination_rate
				FROM hr
                GROUP BY department
				ORDER BY termination_rate DESC;
                
            #### What is the distribution of employees across location state
 
 SELECT location_state,count(*) count
 FROM hr 
 WHERE termdate IS NULL
 GROUP BY location_state;
 
 ## How has the  companys employees count changed on hire date and termdate?
 SELECT year,
		hires,
        terminations,
        hires-terminations AS net_change,
        (terminations/hires)*100 AS change_percent
        FROM(
               SELECT year(hire_date) AS year,
               count(*) AS hires,
               SUM(CASE
               WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
               END) AS terminations
               
        
        
