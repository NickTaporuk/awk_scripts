BEGIN {
    	print ############################################################################
	print ######            Start                                               ######
	print ############################################################################
	FS="[][]"
	locOffset = strftime("%s")
}
{
    split($2,a,"[/: ]")
    match("JanFebMarAprMayJunJulAugSepOctNovDec",a[2])
    a[2] = sprintf("%02d",(RSTART+2)/3)
    secs = mktime(a[3]" "a[2]" "a[1]" "a[4]" "a[5]" "a[6])
    secs = secs + (locOffset - a[7]) * 60 * 60
    print $2, "->", secs
} END {
    print locOffset
}
