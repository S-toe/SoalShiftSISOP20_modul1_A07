#!/bin/bash

input=$(echo $(echo $1 | awk -F '.' '{print $1}') | grep -i "^[a-z]\+$")
#echo $input

if [ $input ]
then

#=====>soal A	membuat sebuah script bash yang dapat menghasilkan password secara acak
#		sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka.

	thisfolder=`pwd`
	this=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1)

	arraya=({a..z})
	arrayA=({A..Z})

	#now=$(date +"%l")
	#hour=$now
	#hour2=$(($hour-1))
	#if(( now >=10))
	#then
		hour=$(date +"%H")
		hour2=$(($hour-1))
	#fi
	#echo $hour-$hour2

	#for i in {0..25}
	#do
	#       echo ${arraya[hour]}-${arrayA[hour]}
	#done

	change1=${arraya[hour]}
	change2=${arraya[hour2]}
	change3=${arrayA[hour]}
	change4=${arrayA[hour2]}
	#echo $change1-$change2-$change3-$change4
	#if(( hour == 22 ))
	#then
	#	echo yes
	#	echo $(date +"%H")
	#fi

#=====>soal C	mengenkripsi nama file yang diinputkan dengan menggunakan konversi
#		huruf (string manipulation) yang disesuaikan dengan jam(0-23)

	filename=$(echo "$input" | tr '[A-Z]' {$change3-ZA-$change4} | tr '[a-z]' {$change1-za-$change2})
	#echo $filename

#=====>soal B	Password acak tersebut disimpan pada file berekstensi.txt dengan
#		nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.

	echo $this > "$filename".txt

	echo "random password telah disimpan ke dalam file bernama" $input".txt yang telah di enkripsi :)"

	#echo $this | tr '[A-Z]' {$change3-ZA-$change4} | tr '[a-z]' {$change1-za-$change2}

	#decrypt=$(echo "$filename" | tr {$change3-ZA-$change4} '[A-Z]' | tr {$change1-za-$change2} '[a-z]')

	#cho $decrypt

	#read x
	#if(( x=="c" ))
	#then
	#	mv $filename.txt $decrypt.txt
	#	mv $thisfolder/p.test $thisfolder/ganti.test
	#fi

else
	echo "argumen yang diinputkan dan HANYA berupa alphabet."
fi

