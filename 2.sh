# !/usr/bin/bash


monitor_memmory () {
while true
do
	timestamp=$( echo `date +"%Y-%m-%d_%H-%M-%S"`)
  	memory_info=$( free -m )
  	all_memory=$( echo $memory_info | awk '{print $8}' ) 
  	usaged_mamory=$( echo $memory_info | awk '{print $9}' )
  	usaged=$(awk "BEGIN{print ($usaged_mamory/$all_memory*100) }"  )
  	free_memory=$( echo $memory_info | awk '{print $10}' )
	mem_info=$( echo "$timestamp;$all_memory;$free_memory;$usaged%" )
    echo $mem_info >> monitoring.csv
    sleep 600
done
}

if [[ "$1" == "START" ]]
then
	touch log.csv

	monitor_memmory &	
	ep_pid=$!
	echo "Current PID: "$ep_pid
	echo $ep_pid > pid
elif [[ "$1" == "STATUS" ]]
	then
	if [ -f pid ]
	then
		echo "Running PID"
	else
		echo "NOT Running PID"
	fi
elif [[ "$1" == "STOP" ]]
	then
	if [ -f pid ]
	then
		read ep_pid < pid
		kill -9 $ep_pid
		rm pid
	else
		echo "Couldn't finish current PID"
	fi
else
	echo "Wrong parameter"
fi