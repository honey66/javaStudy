-- select * FROM tab;

SHOW TABLES;

CREATE TABLE mytest 


CREATE TABLE studytest.mytest (
	id INT AUTO_INCREMENT NOT NULL,
	NAME VARCHAR(20) NULL COMMENT '鍚嶅瓧',
	age VARCHAR(2) NULL,
	PRIMARY KEY (id)
)
ENGINE=INNODB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_general_ci;
CREATE INDEX mytest_id_IDX USING BTREE ON studytest.mytest (id);


-- 寤鸿〃
-- 瀛︾敓琛�
CREATE TABLE `Student`(
    `s_id` VARCHAR(20),
    `s_name` VARCHAR(20) NOT NULL DEFAULT '',
    `s_birth` VARCHAR(20) NOT NULL DEFAULT '',
    `s_sex` VARCHAR(10) NOT NULL DEFAULT '',
    PRIMARY KEY(`s_id`)
);
-- 璇剧▼琛�
CREATE TABLE `Course`(
    `c_id`  VARCHAR(20),
    `c_name` VARCHAR(20) NOT NULL DEFAULT '',
    `t_id` VARCHAR(20) NOT NULL,
    PRIMARY KEY(`c_id`)
);
-- 鏁欏笀琛�
CREATE TABLE `Teacher`(
    `t_id` VARCHAR(20),
    `t_name` VARCHAR(20) NOT NULL DEFAULT '',
    PRIMARY KEY(`t_id`)
);
-- 鎴愮哗琛�
CREATE TABLE `Score`(
    `s_id` VARCHAR(20),
    `c_id`  VARCHAR(20),
    `s_score` INT(3),
    PRIMARY KEY(`s_id`,`c_id`)
);
-- 鎻掑叆瀛︾敓琛ㄦ祴璇曟暟鎹�
INSERT INTO Student VALUES('01' , '璧甸浄' , '1990-01-01' , '鐢�');
INSERT INTO Student VALUES('02' , '閽辩數' , '1990-12-21' , '鐢�');
INSERT INTO Student VALUES('03' , '瀛欓' , '1990-05-20' , '鐢�');
INSERT INTO Student VALUES('04' , '鏉庝簯' , '1990-08-06' , '鐢�');
INSERT INTO Student VALUES('05' , '鍛ㄦ' , '1991-12-01' , '濂�');
INSERT INTO Student VALUES('06' , '鍚村叞' , '1992-03-01' , '濂�');
INSERT INTO Student VALUES('07' , '閮戠' , '1989-07-01' , '濂�');
INSERT INTO Student VALUES('08' , '鐜嬭強' , '1990-01-20' , '濂�');
-- 璇剧▼琛ㄦ祴璇曟暟鎹�
INSERT INTO Course VALUES('01' , '璇枃' , '02');
INSERT INTO Course VALUES('02' , '鏁板' , '01');
INSERT INTO Course VALUES('03' , '鑻辫' , '03');

-- 鏁欏笀琛ㄦ祴璇曟暟鎹�
INSERT INTO Teacher VALUES('01' , '寮犱笁');
INSERT INTO Teacher VALUES('02' , '鏉庡洓');
INSERT INTO Teacher VALUES('03' , '鐜嬩簲');

-- 鎴愮哗琛ㄦ祴璇曟暟鎹�
INSERT INTO Score VALUES('01' , '01' , 80);
INSERT INTO Score VALUES('01' , '02' , 90);
INSERT INTO Score VALUES('01' , '03' , 99);
INSERT INTO Score VALUES('02' , '01' , 70);
INSERT INTO Score VALUES('02' , '02' , 60);
INSERT INTO Score VALUES('02' , '03' , 80);
INSERT INTO Score VALUES('03' , '01' , 80);
INSERT INTO Score VALUES('03' , '02' , 80);
INSERT INTO Score VALUES('03' , '03' , 80);
INSERT INTO Score VALUES('04' , '01' , 50);
INSERT INTO Score VALUES('04' , '02' , 30);
INSERT INTO Score VALUES('04' , '03' , 20);
INSERT INTO Score VALUES('05' , '01' , 76);
INSERT INTO Score VALUES('05' , '02' , 87);
INSERT INTO Score VALUES('06' , '01' , 31);
INSERT INTO Score VALUES('06' , '03' , 34);
INSERT INTO Score VALUES('07' , '02' , 89);
INSERT INTO Score VALUES('07' , '03' , 98);

SHOW TABLES;
SELECT * FROM Teacher ;
SELECT * FROM Course ; -- 课程
SELECT * FROM Score ; -- 中间关系表 分数
SELECT * FROM Student;

-- 等量关系是什么:  维度是什么

-- 1 
SELECT * FROM Score s ,Student st WHERE st.s_id= s.s_id ;

-- 如何使用笛卡尔积
-- 1、查询"01"课程比"02"课程成绩高的学生的信息及课程分数   
SELECT * FROM Score s1,Score s2,Student st WHERE s1.s_id=st.s_id AND s2.s_id=st.s_id AND s1.c_id=01 AND s2.c_id=02 AND s1.s_score > s2.s_score;

-- 2、查询"01"课程比"02"课程成绩低的学生的信息及课程分数
SELECT s.s_id,st.s_name,ROUND(AVG(s.s_score),2) avg1 FROM Score s ,Student st WHERE st.s_id= s.s_id GROUP BY s.s_id HAVING avg1 >60;

-- 3、查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
select s2.s_id ,round(avg(s_score )),s3.* from Score s2 ,Student s3 where s2.s_id =s3.s_id group by s2.s_id HAVING avg(s_score )>60;

-- 4、查询平均成绩小于60分的同学的学生编号和学生姓名和平均成绩        -- (包括有成绩的和无成绩的)
SELECT s.s_id,st.s_name,ROUND(AVG(s.s_score),2) avg1 FROM Score s ,Student st WHERE st.s_id= s.s_id GROUP BY s.s_id HAVING avg1 <60
UNION SELECT st.s_id,st.s_name,0 FROM Student st  WHERE st.s_id NOT IN(SELECT s.s_id FROM Score s);
-- 不用in 做判断
select * from Student st where not exists(select 1 from Score s where st.s_id = s.s_id) ;

-- 5、查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩
SELECT st.s_id,st.s_name,st.s_birth,st.s_sex,s.s_id,COUNT(s.s_id) , COUNT(s.c_id),SUM(s.s_score) FROM Student st , Score s WHERE st.s_id=s.s_id GROUP BY st.s_id;

-- 6、查询"李"姓老师的数量 
SELECT  COUNT(1) FROM Teacher t WHERE t.t_name LIKE "李%";

-- 7、查询学过"张三"老师授课的同学的信息 
SELECT * FROM Teacher t,  Course c,Score s,Student st WHERE t.t_id=c.t_id AND c.c_id=s.c_id AND s.s_id=st.s_id  AND t.t_name="张三";

-- 8、查询没学过"张三"老师授课的同学的信息
SELECT * FROM Student st
WHERE  NOT exists (
	SELECT s.`s_id` 
	FROM Teacher t ,Course c, Score s 
	WHERE t.t_id=c.`t_id` AND s.`c_id`=c.`c_id` AND t.`t_name`='张三' and st.`s_id` = s.`s_id` );


SELECT DISTINCT(a.s_id) ,a.*
FROM Student a 
LEFT JOIN Score b ON a.s_id = b.s_id 
WHERE a.s_id NOT IN 
	(SELECT s_id FROM Score WHERE c_id = 
		(SELECT c_id FROM Course WHERE t_id =
			 (SELECT t_id FROM Teacher WHERE t_name = '张三'))) ;


-- 9、查询学过编号为"01"并且也学过编号为"02"的课程的同学的信息
SELECT distinct(st.s_name ),st.* FROM Teacher t,  Course c,Score s,Student st WHERE t.t_id=c.t_id AND c.c_id=s.c_id AND s.s_id=st.s_id  AND c.`c_id` IN (01,02);

SELECT * 
FROM student 
WHERE s_id IN (SELECT a.`s_id`
		FROM Score a 
		JOIN Score b ON a.s_id = b.s_id
		WHERE a.c_id = '01' AND b.c_id = '02');

-- 10、查询学过编号为"01"但是没有学过编号为"02"的课程的同学的信息
SELECT * FROM Student st ,(SELECT s.`s_id` FROM Score s WHERE s.`c_id`='01') s1
WHERE st.`s_id` = s1.s_id AND st.`s_id` NOT IN (SELECT s.`s_id` FROM Score s WHERE s.`c_id`='02');

-- 11、查询没有学全所有课程的同学的信息 
SELECT * 
FROM Student st 
WHERE st.`s_id` NOT IN (SELECT s.`s_id` FROM Score s GROUP BY s.`s_id` HAVING COUNT(s.`c_id`) = 3);

-- 12、查询至少有一门课与学号为"01"的同学所学相同的同学的信息 
SELECT * FROM Student st1,Score s2 WHERE s2.`s_id`=st1.`s_id` AND s2.`c_id` IN (SELECT s.`c_id` FROM Score s WHERE s.`s_id`='01') AND st1.`s_id`!='01';
-- exists方法
SELECT * FROM Student st1,Score s2 WHERE EXISTS (SELECT 1 FROM Score s WHERE s.`s_id`='01' AND s2.`c_id`=s.`c_id`) AND s2.`s_id`=st1.`s_id` AND st1.`s_id`!='01';


-- 13、查询和"01"号的同学学习的课程完全相同的其他同学的信息 
SELECT s1.`s_id`,s1.`c_id` FROM Score s1 GROUP BY s1.`s_id`,s1.`c_id` HAVING COUNT(s1.`s_id`,s1.`c_id`)==3
SELECT   COUNT(c_id) FROM  Score WHERE s_id = '01' ;







SHOW VARIABLES LIKE '%slow_query_log%';
SET GLOBAL slow_query_log=1;

SELECT * FROM score GROUP BY 


CREATE TABLE `tem` (
`id` INT(11) NOT NULL AUTO_INCREMENT,
`str` CHAR(1) DEFAULT NULL,
PRIMARY KEY (`id`)
) ;

INSERT INTO `tem`(`id`, `str`) VALUES (1, 'A');
INSERT INTO `tem`(`id`, `str`) VALUES (2, 'B');
INSERT INTO `tem`(`id`, `str`) VALUES (3, 'A');
INSERT INTO `tem`(`id`, `str`) VALUES (4, 'C');
INSERT INTO `tem`(`id`, `str`) VALUES (5, 'A');
INSERT INTO `tem`(`id`, `str`) VALUES (6, 'C');
INSERT INTO `tem`(`id`, `str`) VALUES (7, 'B');

SELECT * FROM tem;

SELECT
    @num := @num+1 num,
    id,
    str
FROM
    tem, (SELECT @str := '', @num := 0) t1
ORDER BY
    str, id;
 
 SELECT @num := @num+1 num;
    
    
    
SELECT VERSION();

SELECT
         val,
         ROW_NUMBER()   OVER w AS 'row_number',
         CUME_DIST()    OVER w AS 'cume_dist',
         PERCENT_RANK() OVER w AS 'percent_rank'
       FROM numbers
       WINDOW w AS (ORDER BY val);



