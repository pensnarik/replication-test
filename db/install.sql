\set ON_ERROR_STOP 1

create database :database;

\connect :database

create extension plpythonu;

/* Write your SQL code here. You may include scripts from directories "data" and "schema"

   CREATE TABLE test (id serial, value text);

   \i data/public.test.sql
   \i schema/public/tables/test.sql
*/

create table test (id serial primary key, val bigint);
create index on test using btree (val);

\set bucket_size 1000000

insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;
insert into test (val) select (random()*100000)::bigint from generate_series(1, :bucket_size) n;

analyze test;

