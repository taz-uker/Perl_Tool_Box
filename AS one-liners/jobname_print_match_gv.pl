 perl -lane 'print $F[1] if /OSR_SERVIND(.*?)RTAP/' gv_and_jobs_0614.txt

# this one liner prints JobName in second column of GV match in first column. 
# thus you get the global variable and each job it affects. 