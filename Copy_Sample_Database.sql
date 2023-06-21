create table region 
as select * from snowflake_sample_data.tpch_sf1.region;

create table nation 
as select * from snowflake_sample_data.tpch_sf1.nation;

create table part as
select * from snowflake_sample_data.tpch_sf1.part 
where mod(p_partkey,50) = 8;

create table partsupp as
select * from snowflake_sample_data.tpch_sf1.partsupp
where mod(ps_partkey,50) = 8;

create table supplier as
with sp as (select distinct ps_suppkey from partsupp)
select s.* from snowflake_sample_data.tpch_sf1.supplier s
inner join sp
on s.s_suppkey = sp.ps_suppkey;

create table lineitem as
select l.* from snowflake_sample_data.tpch_sf1.lineitem l
inner join part p
on p.p_partkey = l.l_partkey;

create table orders as
with li as (select distinct l_orderkey from lineitem)
select o.* from snowflake_sample_data.tpch_sf1.orders o
inner join li on o.o_orderkey = li.l_orderkey;

create table customer as
with o as (select distinct o_custkey from orders)
select c.* from snowflake_sample_data.tpch_sf1.customer c
inner join o on c.c_custkey = o.o_custkey;
