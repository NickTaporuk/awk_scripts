#!/usr/bin/awk -f
BEGIN { sd = "20160301"; ed = "20160401"; } 
#$1 "T" $2 >= sd && $1 "T" $2 <= ed

{print $7}
