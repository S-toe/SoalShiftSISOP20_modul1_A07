#!/bin/bash

now=`pwd`

#=====>soal A	Meneentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling
#		sedikit

awk -F '	' 'NR > 1 { a[$13]+=$21 } END { for (b in a) { printf "%.4f",a[b]; print "->", b } }' ${now}/Sample-Superstore.tsv | sort -n > hasil.txt

hasil1="$(awk -F '->' '{print $2}' hasil.txt | head -1)"
print1="$(echo -e "${hasil1}" | sed -e 's/^[[:space:]]*//')"

echo "Region dengan keuntungan paling sedikit adalah:" $print1
echo "	"
#=====>soal B	Menampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
#		sedikit berdasarkan hasil soal poin A

awk -F '	' -v region="$print1" '$13 == region { c[$11]+=$21 } END { for ( d in c ) { printf "%.4f",c[d]; print "->", d }}' ${now}/Sample-Superstore.tsv | sort -n > hasil2.txt

hasil2A=$(awk -F '->' '{print $2}' hasil2.txt | head -1)
hasil2B=$(awk -F '->' 'NR > 1 {print $2}' hasil2.txt | head -1)

print2A="$(echo -e "${hasil2A}" | sed -e 's/^[[:space:]]*//')"
print2B="$(echo -e "${hasil2B}" | sed -e 's/^[[:space:]]*//')"

echo "State dengan keuntungan paling sedikit adalah:" $print2A "dan" $print2B
echo "	"

#=====>soal C	Menampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
#		sedikit berdasarkan 2 negara bagian (state) hasil soal poin B

awk -F '	' -v state1="$print2A" -v state2="$print2B" -v region="$print1" '{ if (($11 == state1 || $11 == state2) && $13 == region) { e[$17]+=$21 }} END { for ( f in e ) { printf "%.4f",e[f]; print "->",f }}' ${now}/Sample-Superstore.tsv | sort -n > hasil3.txt 

echo "Berikut 10 nama produk yang memiliki keuntungan paling sedikit berdasarkan 2 negara bagian:"

awk -F '->' '{printf "	- %s \n", $2}' hasil3.txt | head -10

