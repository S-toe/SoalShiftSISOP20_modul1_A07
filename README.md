# SoalShiftSISOP20_modul1_A07
## Shell Scripting, Cron, dan AWK

Soal Shift Modul 1

## 1. Soal 1

__Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum untuk membuat laporan berdasarkan data yang ada pada file “Sample-Superstore.tsv”. Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa : a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin a c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan laporan tersebut. *Gunakan Awk dan Command pendukung__

File **Sample-Superstore.tsv** disimpan dalam folder `/home/stoe/PRAKTIKUM/MODUL1/`. Pada folder ini dibuat sebuah *bash script* bernama `soal1.sh` yang isinya sebagai berikut :
```php
#!/bin/bash

now=`pwd`

#=====>soal A   Menentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling
#               sedikit

awk -F '        ' 'NR > 1 { a[$13]+=$21 } END { for (b in a) { printf "%.4f",a[b]; print "->", b } }' ${now}/Sample-Superstore.tsv | sort -n > hasil.txt

hasil1="$(awk -F '->' '{print $2}' hasil.txt | head -1)"
print1="$(echo -e "${hasil1}" | sed -e 's/^[[:space:]]*//')"

echo "Region dengan keuntungan paling sedikit adalah:" $print1
echo "  "
#=====>soal B   Menampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
#               sedikit berdasarkan hasil soal poin A

awk -F '        ' -v region="$print1" '$13 == region { c[$11]+=$21 } END { for ( d in c ) { printf "%.4f",c[d]; print "->", d }}' ${now}/Sample-Superstore.tsv | sort -n > hasil2.txt
hasil2A=$(awk -F '->' '{print $2}' hasil2.txt | head -1)
hasil2B=$(awk -F '->' 'NR > 1 {print $2}' hasil2.txt | head -1)

print2A="$(echo -e "${hasil2A}" | sed -e 's/^[[:space:]]*//')"
print2B="$(echo -e "${hasil2B}" | sed -e 's/^[[:space:]]*//')"

echo "State dengan keuntungan paling sedikit adalah:" $print2A "dan" $print2B
echo "  "

#=====>soal C   Menampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
#               sedikit berdasarkan 2 negara bagian (state) hasil soal poin B

awk -F '        ' -v state1="$print2A" -v state2="$print2B" -v region="$print1" '{ if (($11 == state1 || $11 == state2) && $13 == region) { e[$17]+=$21 }} END { for ( f in e ) { printf "%.4f",e[f]; print "->",f }}' ${now}/Sample-Superstore.tsv | sort -n > hasil3.txt
echo "Berikut 10 nama produk yang memiliki keuntungan paling sedikit berdasarkan 2 negara bagian:"

awk -F '->' '{printf "  - %s \n", $2}' hasil3.txt | head -10
```
Untuk soal pertama yaitu soal a, Menentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit. Di sini saya menggunakan `awk` untuk memfilter data yang diminta.
```php
now=`pwd`

awk -F '        ' 'NR > 1 { a[$13]+=$21 } END { for (b in a) { printf "%.4f",a[b]; print "->", b } }' ${now}/Sample-Superstore.tsv | sort -n > hasil.txt

hasil1="$(awk -F '->' '{print $2}' hasil.txt | head -1)"
print1="$(echo -e "${hasil1}" | sed -e 's/^[[:space:]]*//')"

echo "Region dengan keuntungan paling sedikit adalah:" $print1
echo "  "
```
  - now=pwd merupakan variabel now yang menyimpan *full path* dari alamat kita sekarang
  - `awk -F ' '` berarti tab (  ) digunakan sebagai separator tiap kolom atau filed.
  -  `'NR > 1 { a[$13]+=$21 } END { for (b in a) { printf "%.4f",a[b]; print "->", b } }' ${now}/Sample-Superstore.tsv | sort -n > hasil.txt`
  Pemfilteran dilakukan menggunakan file `Sample-Superstore.tsv`. `NR > 1` digunakan agar perhitungan dimulai dari baris kedua dan seterusnya. Array a dibuat untuk menyimpan Region yang berada di kolom 13 sebagai indeks dan menyimpan profit yang berada di kolom 21 kedalamnya, diakhir perintah awk dibuat looping untuk menampilkan array yang tadi dibuat secara terurut dan menyimpannya ke dalam file hasil.txt.
  - `hasil1="$(awk -F '->' '{print $2}' hasil.txt | head -1)"` variabel hasil1 dibuat untuk menyimpan hasil print dari file hasil.txt yang berada urutan teratas.
  -  `print1="$(echo -e "${hasil1}" | sed -e 's/^[[:space:]]*//')"` variabel print1 dibuat untuk menyimpan hasil echo dari variabel hasil1 yang telah dihilangkan spasi pada awal kata sebelum Region sehingga variabel print bisa digunakan untuk memfilter dengan tepat awk berikutnya.

Untuk soal kedua yaitu soal B, Menampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil soal poin A. Di sini saya menggunakan `awk` kembali untuk memfilter data yang diminta.
```php
awk -F '        ' -v region="$print1" '$13 == region { c[$11]+=$21 } END { for ( d in c ) { printf "%.4f",c[d]; print "->", d }}' ${now}/Sample-Superstore.tsv | sort -n > hasil2.txt
hasil2A=$(awk -F '->' '{print $2}' hasil2.txt | head -1)
hasil2B=$(awk -F '->' 'NR > 1 {print $2}' hasil2.txt | head -1)

print2A="$(echo -e "${hasil2A}" | sed -e 's/^[[:space:]]*//')"
print2B="$(echo -e "${hasil2B}" | sed -e 's/^[[:space:]]*//')"

echo "State dengan keuntungan paling sedikit adalah:" $print2A "dan" $print2B
echo "  "
```
  - `awk -F '        ' -v region="$print1" '$13 == region { c[$11]+=$21 } END { for ( d in c ) { printf "%.4f",c[d]; print "->", d }}' ${now}/Sample-Superstore.tsv | sort -n > hasil2.txt` Untuk penjelasan soal ini sama seperti soal A sebelumnya, hanya saja ada tambahan filter `-v region="$print1"` dimana variabel Region dibuat untuk menyimpan hasil dari soal A, kemudian array yang dibuat juga berbeda yaitu menyimpan state dengan Region sesuai soal A dan disimpan kedalam file hasil2.txt.
  - `print2A="$(echo -e "${hasil2A}" | sed -e 's/^[[:space:]]*//')"`
    `print2B="$(echo -e "${hasil2B}" | sed -e 's/^[[:space:]]*//')"` Disini saya menggunakan dua variabel untuk menyimpan hasil dari soal B, dikarenakan akan digunakan untuk soal berikutnya.

Untuk soal ketiga yaitu soal C, Menampilkan 10 nama produk (*product name*) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil soal poin A dan berdasarkan 2 negara bagian (state) hasil soal poin B. Di sini saya menggunakan `awk` kembali untuk memfilter data yang diminta.
```php
awk -F '        ' -v state1="$print2A" -v state2="$print2B" -v region="$print1" '{ if (($11 == state1 || $11 == state2) && $13 == region) { e[$17]+=$21 }} END { for ( f in e ) { printf "%.4f",e[f]; print "->",f }}' ${now}/Sample-Superstore.tsv | sort -n > hasil3.txt
echo "Berikut 10 nama produk yang memiliki keuntungan paling sedikit berdasarkan 2 negara bagian:"

awk -F '->' '{printf "  - %s \n", $2}' hasil3.txt | head -10
```
  - `awk -F '        ' -v state1="$print2A" -v state2="$print2B" -v region="$print1" '{ if (($11 == state1 || $11 == state2) && $13 == region) { e[$17]+=$21 }} END { for ( f in e ) { printf "%.4f",e[f]; print "->",f }}' ${now}/Sample-Superstore.tsv | sort -n > hasil3.txt`. Untuk soal ini juga penjelasannya hampir sama seperti soal sebelumnya, dengan tambahan pemfilteran yaitu variabel `-v state1="$print2A" -v state2="$print2B" -v region="$print1"` untuk menyimpan hasil dari soal A dan B. Array kembali dibuat untuk menyimpan nama produk pada kolom 17 dengan Region sesuai dengan soal A dan State sesuai soal B serta hasilnya disimpan kedalam file hasil3.txt dalam keadaan terurut.
   - `awk -F '->' '{printf "  - %s \n", $2}' hasil3.txt | head -10` digunakan untuk memfilter dan menampilkan 10 nama produk dari file hasil3.txt
   
## 2. Soal 2
__Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide. Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide tersebut cepat diselesaikan. Idenya adalah kalian (a) membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka. (b) Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet. (c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal: password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28, maka akan menjadi huruf b.) dan (d) jangan lupa untuk membuat dekripsinya supaya nama file bisa kembali. HINT: enkripsi yang digunakan adalah caesar cipher. *Gunakan Bash Script__

Dua file script dibuat dan disimpan dalam folder `/home/stoe/PRAKTIKUM/MODUL1/`. Dua script tersebut berfungsi untuk mengenkripsi dan mendekripsi nama file, berikut script yang telah dibuat dengan nama file `soal2_enkripsi` :
```php
#!/bin/bash

input=$(echo $(echo $1 | awk -F '.' '{print $1}') | grep -i "^[a-z]\+$")
#echo $input

if [ $input ]
then

#=====>soal A   membuat sebuah script bash yang dapat menghasilkan password secara acak
#               sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka.

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
        #       echo yes                                                                                                                         #       echo $(date +"%H")
        #fi

#=====>soal C   mengenkripsi nama file yang diinputkan dengan menggunakan konversi
#               huruf (string manipulation) yang disesuaikan dengan jam(0-23)

        filename=$(echo "$input" | tr '[A-Z]' {$change3-ZA-$change4} | tr '[a-z]' {$change1-za-$change2})
        #echo $filename

#=====>soal B   Password acak tersebut disimpan pada file berekstensi.txt dengan
#               nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.

        echo $this > "$filename".txt

        echo "random password telah disimpan ke dalam file bernama" $input".txt yang telah di enkripsi :)"

        #echo $this | tr '[A-Z]' {$change3-ZA-$change4} | tr '[a-z]' {$change1-za-$change2}

        #decrypt=$(echo "$filename" | tr {$change3-ZA-$change4} '[A-Z]' | tr {$change1-za-$change2} '[a-z]')
        
        #cho $decrypt

        #read x
        #if(( x=="c" ))
        #then
        #       mv $filename.txt $decrypt.txt
        #       mv $thisfolder/p.test $thisfolder/ganti.test
        #fi

else
        echo "argumen yang diinputkan dan HANYA berupa alphabet."
```
