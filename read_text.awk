#!/usr/bin/awk -f
BEGIN { 
    FS="\n" 
    RS="" 
    ORS="" 
} 
 
{  
    x=1 
    while ( x<NF ) { 
        print $x "\t" 
        x++ 
    } 
    print $NF "\n" 

    print date -d "06/12/2012 07:21:22" +"%s"

}
 
