#!/bin/bash

input=$(echo $(echo $1 | awk -F '.' '{print $1}') | grep -i "^[a-z]\+$")
#echo $input

now=`pwd`

#=====>soal D	membuat dekripsinya supaya nama file bisa kembali.

if [ $input ]
then

	#dekript

	for target in "${@}"; do
        inode=$(stat -c '%i' "${target}")
        fs=$(df  --output=source "${target}"  | tail -1)
        crtime=$(sudo debugfs -R 'stat <'"${inode}"'>' "${fs}" 2>/dev/null | grep -oP 'crtime.*--\s*\K.*' | awk '{print $4}' | awk -F ':' '{print $1}')
#       print1=$(echo -e "${crtime}" | sed -e 's/^[[:space:]]*//')
#	echo $print1
#       echo $crtime
	done

    	arraya=({a..z})
	arrayA=({A..Z})

	hour=$crtime
	hour2=$(($hour-1))
#	echo $hour-$hour2

   	change1=${arraya[hour]}
	change2=${arraya[hour2]}
	change3=${arrayA[hour]}
	change4=${arrayA[hour2]}

    filename=$(echo "$input" | tr {$change3-ZA-$change4} '[A-Z]' | tr {$change1-za-$change2} '[a-z]')

	echo "apakah Anda ingin mendekripsi nama file yang telah dienkripsi" $input".txt ->" $filename.txt"?"  "Y/N"

	read answer
	if [[ $answer == "Y" ]]
	then
		mv "${now}/$input.txt" "${now}/$filename.txt"
		echo "HOREE.. file" $input".txt telah berhasil di-rename menjadi" $filename".txt"

	elif [[ $answer == "N" ]]
	then
		echo "OK, bye.."
	else
		echo "harusnya ketik "Y" atau "N" :("
	fi
else
	echo "argumen yang diinputkan dan HANYA berupa alphabet dari nama file yang telah di enkripsi."
fi
