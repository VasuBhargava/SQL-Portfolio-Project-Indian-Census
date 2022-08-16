--selecting Tables in SQL

select * from [project 1 SQL].dbo.Data1 order by 'district' asc 
select * from [project 1 SQL]. dbo .[Data2]


--------------------------------------------------------------------------------------------------------------------------


--selecting Literacy Rate greater than 80

select district,Literacy from [project 1 SQL].dbo.Data1 
where Literacy >80


--------------------------------------------------------------------------------------------------------------------------



--no of rows into dataset

select count(*) from [project 1 SQL]..Data1 
select count(*) from [project 1 SQL]..Data1 


--------------------------------------------------------------------------------------------------------------------------


-- dataset for Jharkhand And Bihar

select * from [project 1 SQL]..Data1 
where state in ( 'Jharkhand' , 'Bihar')


--------------------------------------------------------------------------------------------------------------------------


-- population of india

select sum(Population) as Population from [project 1 SQL]..Data2


--------------------------------------------------------------------------------------------------------------------------


-- average growth of india

select state, avg(growth)*100 as 'avg growth' from [project 1 SQL]..Data1 
group by State



--------------------------------------------------------------------------------------------------------------------------



-- top 3 states having highest growth ratio

select top 3 state, avg(growth)*100 as 'avg growth' from [project 1 SQL]..Data1 
group by State order by 'avg growth' desc



--------------------------------------------------------------------------------------------------------------------------



-- top 3 states having Lowest growth ratio

select top 4 state, avg(growth)*100 as 'avg growth' from [project 1 SQL]..Data1 
group by State order by 'avg growth' asc



--------------------------------------------------------------------------------------------------------------------------


-- avg sex ratio

select state, round(avg(Sex_Ratio),0) as 'Avg Sex Ratio' from [project 1 SQL]..Data1 
group by State order by 'Avg Sex Ratio' desc



--------------------------------------------------------------------------------------------------------------------------


-- avg Literacy Rate

select state, round(avg(Literacy),0) as 'Avg literacy Rate' from [project 1 SQL]..Data1 
group by State HAVING round(avg(Literacy),0) > 90 order by 'Avg literacy Rate' desc 



--------------------------------------------------------------------------------------------------------------------------


-- top and bottom 3 states in Litracey Rate
 
drop table if exists #topstates
drop table if exists #bottomstates
create table #topstates
(state nvarchar(255) , topstate float )

insert into #topstates

select state, round(avg(Literacy),0) as 'Avg literacy Rate' from [project 1 SQL]..Data1 
group by State order by 'Avg literacy Rate' desc;

select * from #topstates order by #topstates.topstate desc ;
select top 3  * from #topstates order by #topstates.topstate desc

create table #bottomstates
(state nvarchar(255) , bottomstate float )

insert into #bottomstates

select state, round(avg(Literacy),0) as 'Avg literacy Rate' from [project 1 SQL]..Data1 
group by State order by 'Avg literacy Rate' desc;

select * from #bottomstates order by #bottomstates.bottomstate asc ;

select top 3  * from #bottomstates order by #bottomstates.bottomstate asc





select * from (select top 3  * from #bottomstates order by #bottomstates.bottomstate asc) b
union
select * from  (select top 3  * from #topstates order by #topstates.topstate desc) a
order by 2 desc 


--------------------------------------------------------------------------------------------------------------------------



-- select state name with letter a

select distinct state from [project 1 SQL]..Data1 
where state like 'a%' or STATE like 'b%' OR STATE LIKE 'M%'



--------------------------------------------------------------------------------------------------------------------------


-- select state name with letter 'M' AND  end with letter 'h'


select distinct state from [project 1 SQL]..Data1 
where state like 'M%' and STATE like '%h'


--------------------------------------------------------------------------------------------------------------------------


-- joing both the tables

select a.District,a.State,a.Growth,a.Sex_Ratio,a.Literacy,b.Area_km2,b.Population
from [project 1 SQL]..Data2 as b
left join [project 1 SQL]..Data1 as a on a.District = b.District




--------------------------------------------------------------------------------------------------------------------------


-- total numbers of males and females 


select t4.state, sum(t4.males)totoal_males, sum(t4.females)total_females from 
(select t3.district, t3.state,round(t3.population/(t3.sex_ratio+1),0) males, round((t3.Population*t3.sex_Ratio)/(t3.sex_ratio+1),0) females from
(select t1.district,t1.State , t1.Sex_Ratio/1000 sex_Ratio, t2.Population
from [project 1 SQL]..Data1 as t1
left join [project 1 SQL]..data2 as t2 on t1.district = t2.district) as t3) as t4	
group by t4.State



--------------------------------------------------------------------------------------------------------------------------


-- window 
-- top 3 states having heighest litracy rate 

select a.* from  
(select District,State,Literacy,rank() over(partition by state order by literacy desc) rnk from [project 1 SQL]..Data1 ) a
where a.rnk  in (1,2,3) order by state



--------------------------------------------------------------------------------------------------------------------------


-- top 10 district with most population 

select top 10 District,Population 
from [project 1 SQL]..Data2
order by Population desc 



--------------------------------------------------------------------------------------------------------------------------


-- top 10 Largest district

select top 10 District,Area_km2
from [project 1 SQL]..Data2
order by Area_km2 desc 