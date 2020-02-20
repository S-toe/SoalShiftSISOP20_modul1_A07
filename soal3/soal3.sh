#!/bin/bash
#fungsi download

now=`pwd`

for i in {1..28}
do

#=====>soal A   mendownload gambar dari link yang diberikan dan memberinya nama sesuai ketentuan..

	wget -a wget.log "https://loremflickr.com/320/240/cat" -O pdkt_kusuma_$i

	name1=$(grep "Location" wget.log | tail -1 | awk '{print $2}')
	echo $name1

	if [[ ! $(ls ${now} | grep "Location.log") && ! $(ls ${now} | grep "duplicate") && ! $(ls ${now} | grep "kenangan") ]]
	then
		touch Location.log
		mkdir duplicate kenangan
	fi

#=====>soal C   mengidentifikasi gambar yang identik dari gambar yang didownload tadi serta
#		mengubah namanya menjadi duplicate_nomor apabila identik dan memasukannya ke folder duplicate atau
#		mengubah namanya menjadi kenangan_nomor apabila tidak identik dan memasukannya ke folder kenangan

	if [[ $(grep "$name1" Location.log) ]]
	then
		echo aye
		count1=$(ls duplicate/ |awk -F '_' '{print $2}' | sort -rn | head -1)

		if [[ $count1 ]]
		then
			mv "${now}/pdkt_kusuma_$i" "${now}/duplicate/duplicate_$(($count1+1))"
		else
			mv "${now}/pdkt_kusuma_$i" "${now}/duplicate/duplicate_1"
		fi
	else
		echo nope
		count2=$(ls kenangan/ |awk -F '_' '{print $2}' | sort -rn | head -1)

		if [[ $count2 ]]
                then
                        mv "${now}/pdkt_kusuma_$i" "${now}/kenangan/kenangan_$(($count2+1))"
		else
                        mv "${now}/pdkt_kusuma_$i" "${now}/kenangan/kenangan_1"
		fi

		echo $name1 >> Location.log
	fi

done

# setelah proses download dan pemilahan selesai, serta tidak ada gambar di current directory,
# maka maka lakukan backup seluruh log message menjadi ekstensi .log.bak
cat wget.log >> wget.log.bak
> wget.log

#ambil location

#restu="/cache/resized/65535_49250178128_f4ff21aeca_320_240_nofilter.jpg"

#cek location
#if [[ $(grep "$restu" location.log) ]]
#then
#
#	echo aye
#else
#	echo nope
#fi

#grep "Location" log.log > location.log
