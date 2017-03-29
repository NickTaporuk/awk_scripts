#
# source url http://lib.ru/MAN/DEMOS210/awk.txt
#
BEGIN {
	print("#")
	print("# source url http://lib.ru/MAN/DEMOS210/awk.txt")
	print("#")
	FS="[][]"
}
    	/twiki\/bin\/search/ {
		urls["twiki/bin/search"]++ 
	}
	
	/twiki\/bin\/view\/TWiki/ {
		urls["twiki/bin/view/TWiki/"]++ 
	}

END {
	print(timeNow)
	printf "\t%-25s %6s\n","Url name","Count" 
	printf "\t%-25s%6s\n","__________________________","______" 
	printf "\t%-25s %6s\n","                          ","      " 
	for (name in urls)
		printf "\t%-25s %6d\n", name, urls[name]
}
