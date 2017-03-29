'BEGIN{FS="[][]"}{system("date \"+%s\" -d \""gensub("/", " ", "G", gensub(":", " ", "1", $2))"\"")}'
