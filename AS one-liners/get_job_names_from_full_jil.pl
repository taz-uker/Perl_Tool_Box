 perl -lane 'if (/insert_job/) {($a,$b,$c,$d) = split /\s+/; print $b;}' bat900os.scr.jobs 