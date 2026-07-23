/* cap input rows for the captured run */
options obs=100;
/* the upstream script uses  libname sd1 "d:/sd1";  -- point it at WORK so it runs anywhere */
options validvarname=upcase;
libname sd1 (work);
