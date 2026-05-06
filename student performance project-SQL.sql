----- Pass percenatge---
select round(sum(case when passed='yes' then 1
 else 0 end) *100.0 /count(*),2) as pass
from students;

----- study Hours impact---
select study_hours_per_week,round(avg(final_score),2) as avg_score
from students
group by study_hours_per_week;

----- attendance impact---
select 
    case
       when attendance_rate >= 75 then 'high'
       when attendance_rate >=50 then 'medium'
       else 'low' end as attendance_group,
       round(avg(final_score),2) as avg_score
       from students
       group by attendance_group;
       
       ----- gender analysis---
       select gender,
       round(avg(final_score),2),
       sum(case when passed ='yes' then 1 else 0 end) as pass_count
       from students
       group by gender;
       
       ----- partent education---
       select parent_education,
       round(avg(final_score),2) as avg_score
       from students
       group by parent_education
       order by avg_score;
       
       ----- top 5 students( window function)---
       select * from(select student_id,final_score,
     row_number() over(order by final_score desc) as Rnk
       from students) t
       where rnk <=5;
       
       ----- At risk students---
       select student_id, study_hours_per_week,final_score,attendance_rate
       from students
       where attendance_rate<60 and final_score < 50
       limit 5;
       
       ----- performance gategories---
       select 
       count(case when final_score >70 then 1 end) as good,
       count(case when final_score between 50 and 70 then 1 end) as average,
       count(case when final_score <50 then 1 end) as poor
       from students;
