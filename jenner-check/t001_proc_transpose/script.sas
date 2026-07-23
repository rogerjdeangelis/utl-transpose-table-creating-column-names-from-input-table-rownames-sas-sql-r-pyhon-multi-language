/* SAS solution #1 from
   utl-transpose-table-creating-column-names-from-input-table-rownames-sas-sql-r-pyhon-multi-language.sas
   Transpose a table creating column names from the input table's row names.
   Only change vs. upstream: the libname (d:/sd1) is set to WORK in autoexec.sas
   so the step runs in isolation. The cards4 data and PROC TRANSPOSE are unchanged. */

data sd1.have;
   input cols$ row1 row2 ;
cards4;
COL1 1000 50
COL2 2022 2024
;;;;
run;quit;

proc transpose data=sd1.have out=want;
id cols;
var row1-row2;
run;quit;

proc print data=want;
run;quit;
