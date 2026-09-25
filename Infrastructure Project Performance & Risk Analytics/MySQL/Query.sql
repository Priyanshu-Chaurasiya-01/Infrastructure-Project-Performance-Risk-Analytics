use Infrastructure_Project;

-- 1. Which projects are delayed?
select Project_ID, Project_Name, Status from Projects where Status = "Delayed";

-- 2. Which projects are exceeding budget?
select Project_ID, Project_Name, Planned_Budget_Cr, Actual_Cost_Cr, round((Actual_Cost_Cr-Planned_Budget_Cr), 2)  as Exceed_Amount_Cr 
from Projects where Planned_Budget_Cr < Actual_Cost_Cr order by Exceed_Amount_Cr desc;

-- 3. Which contractors are underperforming?
select Contractor_ID, Contractor_Name, Average_Delay_Days, Performance_Rating from Contractors 
where Performance_Rating < (select avg(Performance_Rating) from contractors) 
and Average_Delay_Days > (select avg(Average_Delay_Days) from contractors);

-- 4. Which project types have the highest risk?
select p.Project_Type, count(r.Risk_ID) as Total_High_Risks from Projects p
join Risks r on p.Project_ID = r.Project_ID
where r.Probability in ('High', 'Very High') or r.Impact in ('High', 'Critical')
group by p.Project_Type order by Total_High_Risks desc;

-- 5. Which regions have the most delays? 
select Region, round(avg(datediff(Actual_End_Date, Planned_End_Date)), 1) as Avg_Delay_Days, 
count(case when Actual_End_Date > Planned_End_Date or Status = "Delayed" then 1 end) as Delayed_Projects_Count from Projects 
group by Region order by Avg_Delay_Days desc;

-- 6. What factors are associated with cost overruns?
select p.Project_Type,
    case 
        when c.Performance_Rating < 3.0 then 'Low (< 3.0)'
        when c.Performance_Rating between 3.0 and 4.0 then 'Medium (3.0 - 4.0)'
        else 'High (> 4.0)'
    end as Contractor_Rating_Tier,
    count(distinct r.Risk_ID) as High_Risk_Count,
    count(p.Project_ID) as Total_Projects,
    round(avg(p.Actual_Cost_Cr - p.Planned_Budget_Cr), 2) as Avg_Cost_Overrun_Cr,
    round(avg((p.Actual_Cost_Cr - p.Planned_Budget_Cr) / p.Planned_Budget_Cr * 100), 2) as Avg_Overrun_Pct
from Projects p
left join Contractors c on p.Contractor_ID = c.Contractor_ID
left join Risks r on p.Project_ID = r.Project_ID and r.Impact in ('High', 'Critical')
where p.Actual_Cost_Cr > p.Planned_Budget_Cr
group by 
    p.Project_Type, 
    Contractor_Rating_Tier
order by Avg_Overrun_Pct desc;

-- 7. Which ongoing projects need management attention?
select p.Project_ID, p.Project_Name, p.Region, c.Contractor_name, 
	round(((p.Actual_Cost_Cr - p.Planned_Budget_Cr) / p.Planned_Budget_Cr) * 100,2) as cost_overrun_percent,
    round(p.Actual_Progress_Pct - p.Planned_Progress_Pct, 2) as progress_variance,
    case
        when p.Actual_Cost_Cr > p.Planned_Budget_Cr and p.Actual_Progress_Pct < p.Planned_Progress_Pct
            then 'Critical Attention'
        when p.Actual_Cost_Cr > p.Planned_Budget_Cr or p.Actual_Progress_Pct < p.Planned_Progress_Pct
            then 'Needs Attention'
        else 'Normal'
    end as attention_level
from projects p left join contractors c on p.contractor_id = c.contractor_id where p.status = 'Ongoing'
order by
    case
        when p.Actual_Cost_Cr > p.Planned_Budget_Cr and p.Actual_Progress_Pct < p.Planned_Progress_Pct then 1
        when p.Actual_Cost_Cr > p.Planned_Budget_Cr or p.Actual_Progress_Pct < p.Planned_Progress_Pct then 2
        else 3
    end;