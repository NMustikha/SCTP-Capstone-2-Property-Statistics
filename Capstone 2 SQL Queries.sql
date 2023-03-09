------------------------------------------
----- SCTP CAPSTONE 2 SQL QUERIES -----
------------------------------------------
----- CREATE SALESPERSON INFO TABLE -----
------------------------------------------
-- drop table if exists salesperson_info cascade;
-- create table if not exists salesperson_info (
-- 	salesperson_id		serial primary key,
-- 	name	text,
-- 	reg_no		text,
-- 	reg_start_date text,
-- 	reg_end_date	text,
-- 	agency_name		text,
-- 	agency_license	text );

-- copy salesperson_info ( name, reg_no, reg_start_date, reg_end_date, agency_name, agency_license )
-- from 'C:\Users\nmust\Downloads\SCTP\COURSE 5 - CAPSTONE 2\CEA Dataset\cea_salesperson_info.csv' delimiter ',' CSV header;

-- select * from salesperson_info;

------------------------------------------
----- CREATE TRANSACTION INFO TABLE -----
------------------------------------------
-- drop table if exists transaction_info cascade;
-- create table if not exists  transaction_info (
-- 	transaction_id		serial primary key,
-- 	salesperson_name	text,
-- 	transaction_date	text,
-- 	salesperson_reg_num text,
-- 	property_type	text,
-- 	transaction_type	text,
-- 	represented text,
-- 	town	text,
-- 	district			text,
-- 	general_location	text );
	
-- copy transaction_info ( salesperson_name, transaction_date, salesperson_reg_num, property_type, transaction_type,
-- 					   represented, town, district, general_location )
-- from 'C:\Users\nmust\Downloads\SCTP\COURSE 5 - CAPSTONE 2\CEA Dataset\cea_property_records.csv' delimiter ',' CSV header;

-- select * from transaction_info;

-----------------------------------------------------
----- CREATE VIEWS FOR CLEANING & MANIPULATION -----
-----------------------------------------------------
----- SALESPERSON INFO VIEW MANIPULATION PART 1 -----
----- Extracting characters after '(' in name -----
-----------------------------------------------------
-- drop view if exists cea_ppl_1 cascade;
-- create view cea_ppl_1 as
-- select salesperson_id, name, right(name, (position(')' in name) - position('(' in name))) as nickname,
-- 	   reg_no, reg_start_date::date, reg_end_date::date, agency_name, agency_license from salesperson_info;
-- select * from cea_ppl_1;
-----------------------------------------------------
----- SALESPERSON INFO VIEW MANIPULATION PART 2 -----
----- Extract characters before ')' in name & Caps -----
-----------------------------------------------------
-- drop view if exists cea_ppl cascade;
-- create view cea_ppl as
-- select salesperson_id, name, upper(left(nickname, length(nickname)- 1)) as alias,
-- 	   reg_no, reg_start_date, reg_end_date, agency_name, agency_license from cea_ppl_1;
-- select * from cea_ppl;
-----------------------------------------------------
----- TRANSACTION INFO VIEW MANIPULATION -----
----- Change transaction_date data type to date -----
-----------------------------------------------------
-- drop view if exists transaction cascade;
-- create view transaction as
-- select transaction_id, salesperson_name, to_date(transaction_date, 'Mon-YY') as transact_date, salesperson_reg_num, property_type,
-- 		 transaction_type, represented, town, district, general_location from transaction_info;
-- select * from transaction;
-----------------------------------------------------
----- TRANSACTION INFO + SALESPERSON INFO VIEW -----
----- Inner join tables for all overlapping rows -----
-----------------------------------------------------
-- drop view if exists transaction_agents cascade;
-- create view transaction_agents as 
-- 		 select transaction_id, transact_date, property_type, transaction_type, represented, town, district, general_location,
-- 		 		s.salesperson_id, salesperson_name, s.name, s.alias, s.reg_no, s.reg_start_date, s.reg_end_date, s.agency_name, s.agency_license
-- 		 from transaction t
-- 		 inner join cea_ppl s 
-- 		 on t.salesperson_reg_num = s.reg_no
-- 		 order by transaction_id;
-- select * from transaction_agents;
-----------------------------------------------------
----- TRANSACTION INFO + SALESPERSON INFO VIEW -----
----- Left join tables & extract nulls for completion -----
-----------------------------------------------------
-- drop view if exists transaction_noagents cascade;
-- create view transaction_noagents as
-- 		 select transaction_id, transact_date, property_type, transaction_type, represented, town, district, general_location,
-- 		 s.salesperson_id, salesperson_name, s.reg_no, s.reg_start_date, s.reg_end_date, s.agency_name, s.agency_license
-- 		 from transaction t
-- 		 left join salesperson_info s 
-- 		 on s.reg_no = t.salesperson_reg_num
-- 	 	 where s.salesperson_id is null;
-- select * from transaction_noagents;

-----------------------------------------------------
----- QUERIES FOR DATA ANALYSIS & INSIGHTS -----
-----------------------------------------------------
----- TOP 10 AGENCIES WITH MOST NO. OF AGENTS -----
-----------------------------------------------------
-- select agency_name, count(*) total_agents
-- from cea_ppl
-- group by agency_name
-- order by total_agents desc
-- limit 5;
-----------------------------------------------------
----- TOP 10 AGENCIES WITH MOST NO. OF TRANSACTIONS -----
-----------------------------------------------------
-- select agency_name, count(*)
-- from transaction_agents
-- group by agency_name
-- order by count(*) desc
-- limit 5;
-----------------------------------------------------
----- TOP 10 AGENTS WITH MOST NO. OF TRANSACTIONS -----
-----------------------------------------------------
-- select name, reg_no, count(*), agency_name
-- from transaction_agents
-- group by name, reg_no, agency_name
-- order by count(*) desc
-- limit 5;
-----------------------------------------------------------------------------------
----- TOP 10 LONGEST SERVING AGENTS WITH THEIR MOST TRANSACTED PROPERTY TYPE -----
-----------------------------------------------------------------------------------
-- select distinct reg_no, name, (reg_end_date - reg_start_date)/365 service_years, property_type, count(*)
-- from transaction_agents
-- group by property_type, name, reg_no, reg_end_date, reg_start_date
-- order by service_years desc, count(*) desc
-- limit 10;
-----------------------------------------------------
----- NO. OF AGENTS WITH CORRESPONDING SERVICE YEARS -----
-----------------------------------------------------
-- with years_of_service as ( 
-- 	select (reg_end_date - reg_start_date)/365 service_years 
-- 	from transaction_agents )

-- select distinct service_years, count(*) from years_of_service
-- group by service_years
-- order by service_years desc;
-----------------------------------------------------
----- PROPERTY TYPE BREAKDOWN -----
-----------------------------------------------------
-- select property_type, count(*) from transaction_agents
-- group by property_type
-- order by count(*) desc;
-----------------------------------------------------
----- PROPERTY TYPE BREAKDOWN WITH YEAR -----
-----------------------------------------------------
-- select date_part('year', transact_date) as year, property_type, count(*)
-- from transaction_agents
-- group by property_type, year
-- order by count(*) desc;
-----------------------------------------------------
----- TRANSACTION TYPE BREAKDOWN WITH REPRESENTED -----
-----------------------------------------------------
-- select represented, transaction_type, count(*)
-- from transaction_agents
-- group by represented, transaction_type
-- order by represented, count(*) desc;
-----------------------------------------------------------------------------------
----- TOP 10 MOST POPULAR TOWN/DISTRICT WITH THEIR MOST TRANSACTED PROPERTY TYPE -----
-----------------------------------------------------------------------------------
-- select town, district, property_type, count(*)
-- from transaction_agents
-- group by town, property_type, district
-- order by count(*) desc;

-----------------------------------------------------
----- EXPORT SQL TO CSV -----
-----------------------------------------------------
-- COPY (select * from transaction_agents) TO 'C:\Users\nmust\Downloads\SCTP\COURSE 5 - CAPSTONE 2\SQL\capstone_output.csv' DELIMITER ',' CSV HEADER;

--------------------------------------------------------------------
----- MAIN CHALLENGES FACED DURING DATA MANIPULATION -----
--------------------------------------------------------------------
--------------------------------------------------------------------
----- (1) PROBLEMS WITH DUPLICATED NAMES (GIVE DIFFERENT NUMBERS) -----
--------------------------------------------------------------------
----- (1a) FIND SAME NAMES WITH MULTIPLE REGISTRATION NO -----
--------------------------------------------------------------------
-- select salesperson_name, count(*), agency_name,
-- 	count(distinct reg_no) as total_reg from transaction_agents
-- group by salesperson_name, agency_name
-- having count(distinct reg_no) > 1
-- order by count(*) desc;
-----------------------------------------------------------------------------------
----- (1b) CHECK WITH START DATE OF LICENSE & SEES THAT SOME LICENSES OVERLAP -----
-----------------------------------------------------------------------------------
-- select salesperson_name, count(*), reg_no, agency_name, reg_start_date
-- from transaction_agents
-- where salesperson_name = ( 
-- 	select salesperson_name from transaction_agents
-- 	group by salesperson_name, agency_name
-- 	having count(distinct reg_no) > 1
-- 	order by count(*) desc
-- 	limit 1)
-- group by salesperson_name, agency_name, reg_no, reg_start_date
-- order by count(*) desc;
------------------------------------------------------------------------
----- (1c) CREATE ALIAS & SEES DIFFERENT NAMES (DIFFERENT PEOPLE) -----
------------------------------------------------------------------------
-- select salesperson_name, alias, count(*), reg_no, agency_name
-- from transaction_agents
-- where salesperson_name = ( 
-- 	select salesperson_name from transaction_agents
-- 	group by salesperson_name, agency_name
-- 	having count(distinct reg_no) > 1
-- 	order by count(*) desc
-- 	limit 1)
-- group by salesperson_name, agency_name, reg_no, alias
-- order by count(*) desc;
--------------------------------------------------------------------
----- (1d) SAME OUTPUT: SALESPERSON NAME + ALIAS VS NAME -----
--------------------------------------------------------------------
-- select salesperson_name, alias, count(*), agency_name,
-- 	count(distinct reg_no) as total_reg from transaction_agents
-- group by salesperson_name, agency_name, alias
-- having count(distinct reg_no) > 1
-- order by count(*) desc;

-- select name, count(*), agency_name,
-- 	count(distinct reg_no) as total_reg from transaction_agents
-- group by name, agency_name
-- having count(distinct reg_no) > 1
-- order by count(*) desc;
-----------------------------------------------------
----- (2) PROBLEMS WITH SALESPERSON_NAME & NAME -----
-----------------------------------------------------
----- (2a) DIFFERENCE IN USING SALESPERSON_NAME & NAME -----
-----------------------------------------------------
-- select salesperson_name, reg_no, count(*), agency_name
-- from transaction_agents
-- group by salesperson_name, reg_no, agency_name
-- order by count(*) desc
-- limit 10;

-- select name, reg_no, count(*), agency_name
-- from transaction_agents
-- group by name, reg_no, agency_name
-- order by count(*) desc
-- limit 10;
-----------------------------------------------------
----- (2b) DIFFERENT SALESPERSON_NAME VS SAME NAME -----
-----------------------------------------------------
-- select distinct reg_no, salesperson_name, name
-- from transaction_agents
-- order by reg_no;