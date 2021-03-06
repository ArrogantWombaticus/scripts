#!/bin/bash

cst=-06
ct=06
tempTZ=$(date +%:::z)
tmpTZ=${tempTZ/:/.}
temp2TZ=${tmpTZ:1}
tz=${temp2TZ%.*}
tzadd=${temp2TZ##.*}

tzdata() {
	localtime=$(date +%H.%M)
	if [[ ${tzadd:3} -eq 0 ]]
	then
		echo "$temp"
		echo "${localtime} + ${temp}" | bc -l
	else
		tdata="${temp}.${tzadd:3}"
		echo "${tdata}"
		echo "${localtime} + ${temp} + ${tdata}" | bc -l
	fi
}

if [[ ${tz} -eq ${ct} ]]
then
	echo "$(date +%H.%M)"
else
	if [[ ${tz} -gt ${cst} ]]
	then 
		if [[ ${tz} -lt 0 ]]
		then
			time=$((${tz:1}))
			hostTime=$((${cst:1}))
			temp=$(echo "$(($hostTime-$time))" | bc -l)
			tzdata
		else
			time=${tz:1}
			temp=$(($time+6))
			tzdata
		fi
	else
		time=$((${tz:1}))
		hostTime=$((${cst:1}))
		temp=$(echo "$(($hostTime-$time))" | bc -l)
		tzdata
	fi
fi
