#!/bin/bash

input=$(echo $(echo $1 | awk -F '.' '{print $1}') | grep -i "^[a-z]\+$")
#echo $input

if [ $input ]
then

#=====>soal A	membuat sebuah script bash yang dapat menghasilkan password secara acak
#		sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka.

	thisfolder=`pwd`
    
    this=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 3 | head -n 1 )
    
    while :
    do
    this=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 3 | head -n 1 )
    echo $this
    if [[ "$this" =~ [^a-zA-Z0-9] ]]
    then
        break
    fi 
    done

    echo $this
	arraya=({a..z})
	arrayA=({A..Z})

		hour=$(date +"%H")
		hour2=$(($hour-1))

	change1=${arraya[hour]}
	change2=${arraya[hour2]}
	change3=${arrayA[hour]}
	change4=${arrayA[hour2]}

#=====>soal B	Password acak tersebut disimpan pada file berekstensi.txt dengan
#		nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.

#	echo $this > "$filename".txt

else
	echo "argumen yang diinputkan dan HANYA berupa alphabet."
fi

