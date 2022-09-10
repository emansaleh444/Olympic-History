-- first table
create type gender AS ENUM ('M','F')
create type  season AS ENUM ('Summer','Winter')
create type medal AS ENUM ('Gold', 'Silver', 'Bronze',  'NA')
create table Athlete_Events (ID Integer ,
        Name varchar(250),
        Gender gender,
        Age  Integer,
        Height float, 
        Weight float,
        Team  varchar (50),
        NOC varchar(3),
            Games varchar(50),
        Year Integer,
        Season season ,
        City varchar(50),
        Sport varchar(50),
          Event varchar(250),
         Medal medal );
        
copy Athlete_Events from 'D:\athlete_events.csv'DELIMITER','CSV HEADER null 'NA';  
--second table
create table NOC_Regions (NOC varchar(3),
        Regions varchar(50),
        Notes varchar(250));
        
copy NOC_Regions from 'D:\noc_regions.csv'DELIMITER','CSV HEADER null ' '; 

-- what is the beging and ending years?
select min (Year),max(year)
from Athlete_Events;
--How many Olympics have been held in 120 years?
select count (Games)
from Athlete_Events;
-- What are total number of medals by season?
select count(Medal),Season,year
from Athlete_Events
group by Season ,year;
--What is gender ratio over seasons?
select round(100*cast(sum(case when Gender = 'M'then 1 else 0 end)as numeric)/count (Gender),2) as Male,
round(100*cast(sum(case when Gender = 'F'then 1 else 0 end)as numeric)/count (Gender),2) as female,
Season,
Year
from Athlete_Events
group by Season,Year;
--What is gender number over medal?
select count(Gender), Gender,Medal
from Athlete_Events
where Medal <>'NA'
group by Gender,Medal;
--Which country has the most athletes?
select NOC_Regions.Regions,count(distinct(Athlete_Events.Name))
from NOC_Regions
join Athlete_Events on NOC_Regions.NOC =Athlete_Events.NOC
group by(NOC_Regions.Regions)
order by count desc
limit 1;
--What is the medal count by country?
select NOC_Regions.Regions,count(Athlete_Events.Medal)
from NOC_Regions
join Athlete_Events on NOC_Regions.NOC =Athlete_Events.NOC
where Medal<>'NA'
group by (NOC_Regions.Regions);
--Who has participated in the most Olympic Games?
select count(distinct(Games)),Name
from Athlete_Events
where medal<>'NA'
group by Name
order by count desc
limit 1;
--Who are top athletes by medal?
select count(Medal),Name
from Athlete_Events
where medal<>'NA'
group by Name
order by count desc
limit 1;

