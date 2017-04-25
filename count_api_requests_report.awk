#!/usr/bin/awk -f
BEGIN {
	FS="[][]"
}
{
    split($2,a,"[/: ]")
    timepoint=mktime(a[3]" "(match("JanFebMarAprMayJunJulAugSepOctNovDec",a[2])+2)/3" "a[1]" "a[4]" "a[5]" "a[6])
}

  #URL Search by size tire
	/\/api\/size/ && timepoint >= lowerDateRange {
		urls["/api/size"]++
	}

  #URL Search by vehicle
	/api\/by_vehicle/ && timepoint >= lowerDateRange {
		urls["api/by_vehicle"]++
	}

  #URL Search by size
	/\/api\/search\/by_size/ && timepoint >= lowerDateRange {
		urls["/api/search/by_size"]++
	}

  #URL Search by vehicle
	/\/api\/search\/by_vehicle/ && timepoint >= lowerDateRange {
		urls["/api/search/by_vehicle"]++
	}
  #URL Search by brand
	/\/api\/search\/by_brand/ && timepoint >= lowerDateRange {
		urls["/api/search/by_brand"]++
	}
  #URL Search by vehicle reverse
	/\/api\/vehicle\/reverse/ && timepoint >= lowerDateRange {
		urls["/api/vehicle/reverse"]++
	}
  #URL Search by size reverse
	/\/api\/size\/reverse/ && timepoint >= lowerDateRange {
		urls["/api/size/reverse"]++
	}
  #URL Search by vehicle fitment
	/\/api\/vehicle\/fitment/ && timepoint >= lowerDateRange {
		urls["/api/vehicle/fitment"]++
	}
  #URL Search by tire category
	/\/api\/tire\/category/ && timepoint >= lowerDateRange {
		urls["/api/tire/category"]++
	}
  #URL Search suppression by vehicle type
	/\/api\/for_store\/suppression\/by_vehtype/ && timepoint >= lowerDateRange {
		urls["/api/for_store/suppression/by_vehtype"]++
	}
  #URL Search by suppression by store
	/\/api\/for_store\/suppression\/by_store/ && timepoint >= lowerDateRange {
		urls["/api/for_store/suppression/by_store"]++
	}
  #URL Search by store web source
	/\/api\/for_store\/websource/ && timepoint >= lowerDateRange {
		urls["/api/for_store/websource"]++
	}
############# PROXY METHODS ##################
  #URL Proxy method. Show tires, that available in catalog, search by size, with filtered data;Using store and vehtype, websource  filters;
	/\/api\/for_store\/search\/by_size/ && timepoint >= lowerDateRange {
		urls["/api/for_store/search/by_size"]++
	}
  #URL Proxy method. Show tires, that available in catalog, by brand and number. Using websource  filters;
	/\/api\/for_store\/search\/by_brand/ && timepoint >= lowerDateRange {
		urls["/api/for_store/search/by_brand"]++
	}
  #URL Proxy method. Show tires, that available in catalog, by brand and number. Using websource  filters;
	/\/api\/for_store\/search\/by_brand/ && timepoint >= lowerDateRange {
		urls["/api/for_store/search/by_brand"]++
	}
  #URL Proxy method. Show tires, that available in catalog, by vehicle. Using store and vehtype, websource  filters;
	/\/api\/for_store\/search\/by-vehicle/ && timepoint >= lowerDateRange {
		urls["/api/for_store/search/by-vehicle"]++
	}
  #URL Proxy method. To get the tire catalog details. Used websource, store filters.
	/\/api\/for_store\/tire\/category/ && timepoint >= lowerDateRange {
		urls["/api/for_store/tire/category"]++
	}
  #URL Proxy method. To retrieve the entire distinct vehicle rim diameter values.use websource .
	/\/api\/for_store\/size\/reverse/ && timepoint >= lowerDateRange {
		urls["/api/for_store/size/reverse"]++
	}

END {
	printf "\t%-40s%6s\n","|=======================================","|========|"
	printf "\t%-40s %6s\n"," Url name"," Count "
	printf "\t%-40s%6s\n","|=======================================","|========|"
	printf "\t%-40s %6s\n","                                  ","      "
	for (name in urls)
		printf "\t%-40s %6d\n", name, urls[name]
	printf "\t%-40s%6s\n","|=======================================","|========|"
	printf "\t%-40s %6s\n"," Url name"," Count "
	printf "\t%-40s%6s\n","|=======================================","|========|"
}