/* SAS solution #2 from
   utl-transpose-table-creating-column-names-from-input-table-rownames-sas-sql-r-pyhon-multi-language.sas
   The same transpose done in pure PROC SQL: sum(case when cols=...) folded over a
   UNION ALL of one SELECT per input row, turning row names into column names.
   Only change vs. upstream: the libname (d:/sd1) is set to WORK in autoexec.sas so
   the step runs in isolation. The SQL is unchanged from the repo. */

data sd1.have;
   input cols$ row1 row2 ;
cards4;
COL1 1000 50
COL2 2022 2024
;;;;
run;quit;

proc sql;
  create
    table want as
  select
    'ROW1' as ROWS
    ,sum(case when (cols="COL1") then ROW1 end) as COL1
    ,sum(case when (cols="COL2") then ROW1 end) as COL2
  from
     sd1.have
  union
     all
  select
    'ROW2'  as ROWS
    ,sum(case when (cols="COL1") then ROW2 end) as COL1
    ,sum(case when (cols="COL2") then ROW2 end) as COL2
  from
     sd1.have
;quit;

proc print data=want;
run;quit;
