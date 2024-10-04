%let pgm=utl-transpose-table-creating-column-names-from-input-table-rownames-sas-sql-r-pyhon-multi-language;

Transpose table creating column names from input table rownames sas sql r pyhon multi language

 SQL is not designed to solve this type of problem, however it is possible with sql arrays.
 Note you can build sql arrays outside sqldf in R and then use the generated statements in
 the  call to sqldf.


             SOILUTIONS
                  1 sas transpose
                  2 sas sql (with and without sql arrays
                  3 r sql
                  4 python sql
                  5 r data table language

github
https://tinyurl.com/y4edt4c9
https://github.com/rogerjdeangelis/utl-transpose-table-creating-column-names-from-input-table-rownames-sas-sql-r-pyhon-multi-language

Related to
stakoverflow R
https://tinyurl.com/56cv57v6
https://stackoverflow.com/questions/79050598/pivoting-dataframe-from-one-column-across-many-in-r

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/**************************************************************************************************************************/
/*                          |                                                  |                                          */
/*        INPUT             |            PROCESS                               |  OUTPUT                                  */
/*                          |                                                  |                                          */
/*                          |                                                  |                                          */
/*   COLS    ROW1    ROW2   |   Transpose a table creating column              |   ROWS    COL1    COL2                   */
/*                          |   names from input table rownames                |                                          */
/*   COL1    1000      50   |   sas r pyhon multi language;                    |   ROW1    1000    2022                   */
/*   COL2    2022    2024   |                                                  |   ROW2      50    2024                   */
/*                          |                                                  |                                          */
/*                          |--------------------------------------------------|                                          */
/*                          |                                                  |                                          */
/*                          |   SAS                                            |                                          */
/*                          |   ===                                            |                                          */
/*                          |                                                  |                                          */
/*                          |   proc transpose data=sd1.have                   |                                          */
/*                          |       out=want;                                  |                                          */
/*                          |   id cols;                                       |                                          */
/*                          |   var row1-row2;                                 |                                          */
/*                          |   run;quit;                                      |                                          */
/*                          |                                                  |                                          */
/*                          |--------------------------------------------------|                                          */
/*                          |                                                  |                                          */
/*                          |                                                  |                                          */
/*                          |  R and Python SQL                                |                                          */
/*                          |                                                  |                                          */
/*                          |  select                                          |                                          */
/*                          |     %do_over(_idx,phrase=%str(                   |                                          */
/*                          |       "ROW?" as ROWS                             |                                          */
/*                          |       ,sum(case when (cols="COL1")               |                                          */
/*                          |           then ROW? end) as COL1                 |                                          */
/*                          |       ,sum(case when (cols="COL2")               |                                          */
/*                          |           then ROW? end) as COL2                 |                                          */
/*                          |     ),between=from sd1.have union all select)    |                                          */
/*                          |                                                  |                                          */
/*                          |--------------------------------------------------|                                          */
/*                          |                                                  |                                          */
/*                          | R data table language                            |                                          */
/*                          |                                                  |                                          */
/*                          | SOAPBOX ON                                       |                                          */
/*                          |  Are you better off learning the data.table      |                                          */
/*                          |  language or sql                                 |                                          */
/*                          | SOAPBOX OFF                                      |                                          */
/*                          |                                                  |                                          */
/*                          | want<-data.table::transpose(have                 |                                          */
/*                          |  ,make.names = "COLS")                           |                                          */
/*                          | rownames(want)<-colnames(have)[c(2,3)]           |                                          */
/*                          |                                                  |                                          */
/*                          |                                                  |                                          */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/


options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
   input cols$ row1 row2 ;
cards4;
COL1 1000 50
COL2 2022 2024
;;;;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  SD1.HAVE total obs=2                                                                                                  */
/*                                                                                                                        */
/*  Obs    COLS    ROW1    ROW2                                                                                           */
/*                                                                                                                        */
/*   1     COL1    1000      50                                                                                           */
/*   2     COL2    2022    2024                                                                                           */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                   _
/ |  ___  __ _ ___  | |_ _ __ __ _ _ __  ___ _ __   ___  ___  ___
| | / __|/ _` / __| | __| `__/ _` | `_ \/ __| `_ \ / _ \/ __|/ _ \
| | \__ \ (_| \__ \ | |_| | | (_| | | | \__ \ |_) | (_) \__ \  __/
|_| |___/\__,_|___/  \__|_|  \__,_|_| |_|___/ .__/ \___/|___/\___|
                                            |_|
*/

proc transpose data=sd1.have out=want;
id cols;
var row1-row2;
run;quit;

/*___                              _
|___ \   ___  __ _ ___   ___  __ _| |
  __) | / __|/ _` / __| / __|/ _` | |
 / __/  \__ \ (_| \__ \ \__ \ (_| | |
|_____| |___/\__,_|___/ |___/\__, |_|
                                |_|
 _ __   ___    ___  __ _| |   __ _ _ __ _ __ __ _ _   _ ___
| `_ \ / _ \  / __|/ _` | |  / _` | `__| `__/ _` | | | / __|
| | | | (_) | \__ \ (_| | | | (_| | |  | | | (_| | |_| \__ \
|_| |_|\___/  |___/\__, |_|  \__,_|_|  |_|  \__,_|\__, |___/
                      |_|                         |___/
*/

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

/*         _
 ___  __ _| |   __ _ _ __ _ __ __ _ _   _ ___
/ __|/ _` | |  / _` | `__| `__/ _` | | | / __|
\__ \ (_| | | | (_| | |  | | | (_| | |_| \__ \
|___/\__, |_|  \__,_|_|  |_|  \__,_|\__, |___/
        |_|                         |___/
*/

%array(_idx,values=1-2);

proc sql;
  create
    table want as
  select
     %do_over(_idx,phrase=%str(
       "ROW?" as ROWS
       ,sum(case when (cols="COL1") then ROW? end) as COL1
       ,sum(case when (cols="COL2") then ROW? end) as COL2
     ),between=from sd1.have union all select)
  from
     sd1.have
;quit;

/*                                _
  __ _  ___ _ __     ___ ___   __| | ___
 / _` |/ _ \ `_ \   / __/ _ \ / _` |/ _ \
| (_| |  __/ | | | | (_| (_) | (_| |  __/
 \__, |\___|_| |_|  \___\___/ \__,_|\___|
 |___/
*/

If  you want the sql clauses;
data _null_;
     %do_over(_idx,phrase=%str(put
       "'ROW?' as ROWS" /
       ",sum(case when (cols='COL1') then ROW? end) as COL1" /
       ",sum(case when (cols='COL2') then ROW? end) as COL2" /
     "),between=from sd1.have union all select)";));
run;quit;


Select
'ROW1' as ROWS
,sum(case when (cols='COL1') then ROW1 end) as COL1
,sum(case when (cols='COL2') then ROW1 end) as COL2
from sd1.have union all select)
'ROW2' as ROWS
,sum(case when (cols='COL1') then ROW2 end) as COL1
,sum(case when (cols='COL2') then ROW2 end) as COL2
from
  sd1.have

/**************************************************************************************************************************/
/*                                                                                                                        */
/* Up to 40 obs from last table WORK.WANT total obs=2 04OCT2024:08:39:22                                                  */
/*                                                                                                                        */
/* Obs    ROWS    COL1    COL2                                                                                            */
/*                                                                                                                        */
/*  1     ROW1    1000    2022                                                                                            */
/*  2     ROW2      50    2024                                                                                            */
/*                                                                                                                        */
/* GENERATED CODE (VERY SLIGHTLY EDITED                                                                                   */
/* ======================================                                                                                 */
/*                                                                                                                        */
/* Select                                                                                                                 */
/* 'ROW1' as ROWS                                                                                                         */
/* ,sum(case when (cols='COL1') then ROW1 end) as COL1                                                                    */
/* ,sum(case when (cols='COL2') then ROW1 end) as COL2                                                                    */
/* from sd1.have union all select)                                                                                        */
/* 'ROW2' as ROWS                                                                                                         */
/* ,sum(case when (cols='COL1') then ROW2 end) as COL1                                                                    */
/* ,sum(case when (cols='COL2') then ROW2 end) as COL2                                                                    */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*____                  _
|___ /   _ __ ___  __ _| |
  |_ \  | `__/ __|/ _` | |
 ___) | | |  \__ \ (_| | |
|____/  |_|  |___/\__, |_|
           _         |_|
 ___  __ _| |   __ _ _ __ _ __ __ _ _   _ ___
/ __|/ _` | |  / _` | `__| `__/ _` | | | / __|
\__ \ (_| | | | (_| | |  | | | (_| | |_| \__ \
|___/\__, |_|  \__,_|_|  |_|  \__,_|\__, |___/
        |_|                         |___/
*/

%array(_idx,values=1-2);

%utl_submit_r64x('
library(haven);
library(sqldf);
source(`c:/oto/fn_tosas9x.R`);
have<-read_sas(`d:/sd1/have.sas7bdat`);
print(have);
want<-sqldf(
   "select
     %do_over(_idx,phrase=%str(
       `ROW?` as ROWS
       ,sum(case when (cols=`COL1`) then ROW? end) as COL1
       ,sum(case when (cols=`COL2`) then ROW? end) as COL2
     ),between=from have union all select)
  from
     have
  ");
want;
fn_tosas9x(
      inp    = want
     ,outlib =`d:/sd1/`
     ,outdsn =`rwant`
     );
',resolve=Y );

/*
 _ __   ___     __ _ _ __ _ __ __ _ _   _ ___
| `_ \ / _ \   / _` | `__| `__/ _` | | | / __|
| | | | (_) | | (_| | |  | | | (_| | |_| \__ \
|_| |_|\___/   \__,_|_|  |_|  \__,_|\__, |___/
                                    |___/
*/

%utl_rbeginx;
parmcards4;
library(haven);
library(sqldf);
source("c:/oto/fn_tosas9x.R");
have<-read_sas("d:/sd1/have.sas7bdat");
print(have);
want<-sqldf(
 'select
    "ROW_1" as ROWSZ
    ,sum(case when (cols="COL1") then ROW1 end) as COL1
    ,sum(case when (cols="COL2") then ROW1 end) as COL2
  from
     have
  union
     all
  select
    "ROW_2"  as ROWSZ
    ,sum(case when (cols="COL1") then ROW2 end) as COL1
    ,sum(case when (cols="COL2") then ROW2 end) as COL2
  from
     have
  ');
want;
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="rwant"
     );
;;;;
%utl_rendx;

proc print data=sd1.rwant;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* R                                                                                                                      */
/*                                                                                                                        */
/* > want;                                                                                                                */
/*   ROWS COL1 COL2                                                                                                       */
/* 1 ROW1 1000 2022                                                                                                       */
/* 2 ROW2   50 2024                                                                                                       */
/*                                                                                                                        */
/* SAS                                                                                                                    */
/*                                                                                                                        */
/* ROWNAMES    ROWS    COL1    COL2                                                                                       */
/*                                                                                                                        */
/*     1       ROW1    1000    2022                                                                                       */
/*     2       ROW2      50    2024                                                                                       */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*  _                 _   _                             _
| || |    _ __  _   _| |_| |__   ___  _ __    ___  __ _| |
| || |_  | `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` | |
|__   _| | |_) | |_| | |_| | | | (_) | | | | \__ \ (_| | |
   |_|   | .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__, |_|
         |_|    |___/                                |_|
*/

proc datasets lib=sd1 nolist nodetails;
 delete pywant;
run;quit;

%utl_pybeginx
parmcards4;
exec(open('c:/oto/fn_python.py').read())
have,meta = ps.read_sas7bdat('d:/sd1/have.sas7bdat')
want=pdsql('''
  select
    "ROW_1" as ROWS
    ,sum(case when (cols="COL1") then ROW1 end) as COL1
    ,sum(case when (cols="COL2") then ROW1 end) as COL2
  from
     have
  union
     all
  select
    "ROW_2"  as ROWS
    ,sum(case when (cols="COL1") then ROW2 end) as COL1
    ,sum(case when (cols="COL2") then ROW2 end) as COL2
  from
     have
   ''')
print(want)
fn_tosas9x(want,outlib='d:/sd1/',outdsn='pywant',timeest=3)
;;;;
%utl_pyendx

proc print data=sd1.pywant;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* PYTHON                                                                                                                 */
/*                                                                                                                        */
/*      ROWS    COL1    COL2                                                                                              */
/*  0  ROW_1  1000.0  2022.0                                                                                              */
/*  1  ROW_2    50.0  2024.0                                                                                              */
/*                                                                                                                        */
/* SAS                                                                                                                    */
/*                                                                                                                        */
/*  ROWS     COL1    COL2                                                                                                 */
/*                                                                                                                        */
/*  ROW_1    1000    2022                                                                                                 */
/*  ROW_2      50    2024                                                                                                 */
/*                                                                                                                        */
/**************************************************************************************************************************/
/*          _       _          _        _     _
 _ __    __| | __ _| |_ __ _  | |_ __ _| |__ | | ___
| `__|  / _` |/ _` | __/ _` | | __/ _` | `_ \| |/ _ \
| |    | (_| | (_| | || (_| | | || (_| | |_) | |  __/
|_|     \__,_|\__,_|\__\__,_|  \__\__,_|_.__/|_|\___|

 _
| | __ _ _ __   __ _ _   _  __ _  __ _  ___
| |/ _` | `_ \ / _` | | | |/ _` |/ _` |/ _ \
| | (_| | | | | (_| | |_| | (_| | (_| |  __/
|_|\__,_|_| |_|\__, |\__,_|\__,_|\__, |\___|
               |___/             |___/
*/

%utl_rbeginx;
parmcards4;
library(haven)
library(data.table)
source("c:/oto/fn_tosas9x.R")
have<-read_sas("d:/sd1/have.sas7bdat")
print(have)
want<-data.table::transpose(have
 ,make.names = "COLS")
rownames(want)<-colnames(have)[c(2,3)]
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*                                                                                                                        */
/*                                                                                                                        */
/*  > want                                                                                                                */
/*       COL1 COL2                                                                                                        */
/*  ROW1 1000 2022                                                                                                        */
/*  ROW2   50 2024                                                                                                        */
/*                                                                                                                        */
/* SAS                                                                                                                    */
/*                                                                                                                        */
/*  ROWNAMES    COL1    COL2                                                                                              */
/*                                                                                                                        */
/*    ROW1      1000    2022                                                                                              */
/*    ROW2        50    2024                                                                                              */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
