#!/bin/bash

cst=-06
ct=06
tempTZ=$(date +%:::z | sed -r 's/[:]+/./g')
temp2TZ=${tempTZ:1}
tz=${temp2TZ%.*}
tzadd=${temp2TZ##.*}

tzdata() {
	if [[ ${tzadd:3} -eq 0 ]]
	then
		echo "$temp"
	else
		echo "$temp.${tzadd:3}"
	fi
}

if [[ ${tz} -eq ${ct} ]]
then
	timezone=${cst}
	echo "${timezone:1}"
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
