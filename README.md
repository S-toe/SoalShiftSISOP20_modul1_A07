
# SoalShiftSISOP20_modul1_A07

## Shell Scripting, Cron, dan AWK

  

Soal Shift Modul 1

  

## 1. Soal 1

  

__Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum untuk membuat laporan berdasarkan data yang ada pada file “Sample-Superstore.tsv”. Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa : a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin a c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan laporan tersebut. *Gunakan Awk dan Command pendukung__

  

File **Sample-Superstore.tsv** disimpan dalam folder `/home/stoe/PRAKTIKUM/MODUL1/`. Pada folder ini dibuat sebuah *bash script* bernama `soal1.sh` yang isinya sebagai berikut :

```bash

#!/bin/bash

  

now=`pwd`

  

#=====>soal A Menentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling

# sedikit

  

awk -F ' '  'NR > 1 { a[$13]+=$21 } END { for (b in a) { printf "%.4f",a[b]; print "->", b } }'  ${now}/Sample-Superstore.tsv | sort -n > hasil.txt

  

hasil1="$(awk -F '->' '{print $2}' hasil.txt | head -1)"

print1="$(echo -e "${hasil1}" | sed -e 's/^[[:space:]]*//')"

  

echo  "Region dengan keuntungan paling sedikit adalah:"  $print1

echo  " "

#=====>soal B Menampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling

# sedikit berdasarkan hasil soal poin A

  

awk -F ' ' -v region="$print1"  '$13 == region { c[$11]+=$21 } END { for ( d in c ) { printf "%.4f",c[d]; print "->", d }}'  ${now}/Sample-Superstore.tsv | sort -n > hasil2.txt

hasil2A=$(awk -F '->' '{print $2}' hasil2.txt | head -1)

hasil2B=$(awk -F '->' 'NR > 1 {print $2}' hasil2.txt | head -1)

  

print2A="$(echo -e "${hasil2A}" | sed -e 's/^[[:space:]]*//')"

print2B="$(echo -e "${hasil2B}" | sed -e 's/^[[:space:]]*//')"

  

echo  "State dengan keuntungan paling sedikit adalah:"  $print2A  "dan"  $print2B

echo  " "

  

#=====>soal C Menampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling

# sedikit berdasarkan 2 negara bagian (state) hasil soal poin B

  

awk -F ' ' -v state1="$print2A" -v state2="$print2B" -v region="$print1"  '{ if (($11 == state1 || $11 == state2) && $13 == region) { e[$17]+=$21 }} END { for ( f in e ) { printf "%.4f",e[f]; print "->",f }}'  ${now}/Sample-Superstore.tsv | sort -n > hasil3.txt

echo  "Berikut 10 nama produk yang memiliki keuntungan paling sedikit berdasarkan 2 negara bagian:"

  

awk -F '->'  '{printf " - %s \n", $2}' hasil3.txt | head -10

```

1) **Untuk soal pertama yaitu soal A, Menentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit. Di sini saya menggunakan `awk` untuk memfilter data yang diminta.**

```bash

now=`pwd`

  

awk -F ' '  'NR > 1 { a[$13]+=$21 } END { for (b in a) { printf "%.4f",a[b]; print "->", b } }'  ${now}/Sample-Superstore.tsv | sort -n > hasil.txt

  

hasil1="$(awk -F '->' '{print $2}' hasil.txt | head -1)"

print1="$(echo -e "${hasil1}" | sed -e 's/^[[:space:]]*//')"

  

echo  "Region dengan keuntungan paling sedikit adalah:"  $print1

echo  " "

```

- now=pwd merupakan variabel now yang menyimpan *full path* dari alamat kita sekarang

-  `awk -F ' '` berarti tab ( ) digunakan sebagai separator tiap kolom atau filed.

-  `'NR > 1 { a[$13]+=$21 } END { for (b in a) { printf "%.4f",a[b]; print "->", b } }' ${now}/Sample-Superstore.tsv | sort -n > hasil.txt`

Pemfilteran dilakukan menggunakan file `Sample-Superstore.tsv`. `NR > 1` digunakan agar perhitungan dimulai dari baris kedua dan seterusnya. Array a dibuat untuk menyimpan Region yang berada di kolom 13 sebagai indeks dan menyimpan profit yang berada di kolom 21 kedalamnya, diakhir perintah awk dibuat looping untuk menampilkan array yang tadi dibuat secara terurut dan menyimpannya ke dalam file hasil.txt.

-  `hasil1="$(awk -F '->' '{print $2}' hasil.txt | head -1)"` variabel hasil1 dibuat untuk menyimpan hasil print dari file hasil.txt yang berada urutan teratas.

-  `print1="$(echo -e "${hasil1}" | sed -e 's/^[[:space:]]*//')"` variabel print1 dibuat untuk menyimpan hasil echo dari variabel hasil1 yang telah dihilangkan spasi pada awal kata sebelum Region sehingga variabel print bisa digunakan untuk memfilter dengan tepat awk berikutnya.

  

2) **Untuk soal kedua yaitu soal B, Menampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil soal poin A. Di sini saya menggunakan `awk` kembali untuk memfilter data yang diminta.**

```bash

awk -F ' ' -v region="$print1"  '$13 == region { c[$11]+=$21 } END { for ( d in c ) { printf "%.4f",c[d]; print "->", d }}'  ${now}/Sample-Superstore.tsv | sort -n > hasil2.txt

hasil2A=$(awk -F '->' '{print $2}' hasil2.txt | head -1)

hasil2B=$(awk -F '->' 'NR > 1 {print $2}' hasil2.txt | head -1)

  

print2A="$(echo -e "${hasil2A}" | sed -e 's/^[[:space:]]*//')"

print2B="$(echo -e "${hasil2B}" | sed -e 's/^[[:space:]]*//')"

  

echo  "State dengan keuntungan paling sedikit adalah:"  $print2A  "dan"  $print2B

echo  " "

```

-  `awk -F ' ' -v region="$print1" '$13 == region { c[$11]+=$21 } END { for ( d in c ) { printf "%.4f",c[d]; print "->", d }}' ${now}/Sample-Superstore.tsv | sort -n > hasil2.txt` Untuk penjelasan soal ini sama seperti soal A sebelumnya, hanya saja ada tambahan filter `-v region="$print1"` dimana variabel Region dibuat untuk menyimpan hasil dari soal A, kemudian array yang dibuat juga berbeda yaitu menyimpan state dengan Region sesuai soal A dan disimpan kedalam file hasil2.txt.

-  `print2A="$(echo -e "${hasil2A}" | sed -e 's/^[[:space:]]*//')"`

`print2B="$(echo -e "${hasil2B}" | sed -e 's/^[[:space:]]*//')"` Disini saya menggunakan dua variabel untuk menyimpan hasil dari soal B, dikarenakan akan digunakan untuk soal berikutnya.

  

3) **Untuk soal ketiga yaitu soal C, Menampilkan 10 nama produk (*product name*) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil soal poin A dan berdasarkan 2 negara bagian (state) hasil soal poin B. Di sini saya menggunakan `awk` kembali untuk memfilter data yang diminta.**

```bash

awk -F ' ' -v state1="$print2A" -v state2="$print2B" -v region="$print1"  '{ if (($11 == state1 || $11 == state2) && $13 == region) { e[$17]+=$21 }} END { for ( f in e ) { printf "%.4f",e[f]; print "->",f }}'  ${now}/Sample-Superstore.tsv | sort -n > hasil3.txt

echo  "Berikut 10 nama produk yang memiliki keuntungan paling sedikit berdasarkan 2 negara bagian:"

  

awk -F '->'  '{printf " - %s \n", $2}' hasil3.txt | head -10

```

-  `awk -F ' ' -v state1="$print2A" -v state2="$print2B" -v region="$print1" '{ if (($11 == state1 || $11 == state2) && $13 == region) { e[$17]+=$21 }} END { for ( f in e ) { printf "%.4f",e[f]; print "->",f }}' ${now}/Sample-Superstore.tsv | sort -n > hasil3.txt`. Untuk soal ini juga penjelasannya hampir sama seperti soal sebelumnya, dengan tambahan pemfilteran yaitu variabel `-v state1="$print2A" -v state2="$print2B" -v region="$print1"` untuk menyimpan hasil dari soal A dan B. Array kembali dibuat untuk menyimpan nama produk pada kolom 17 dengan Region sesuai dengan soal A dan State sesuai soal B serta hasilnya disimpan kedalam file hasil3.txt dalam keadaan terurut.

-  `awk -F '->' '{printf " - %s \n", $2}' hasil3.txt | head -10` digunakan untuk memfilter dan menampilkan 10 nama produk dari file hasil3.txt
## Revisi soal no 1.
Mengubah semua separator `awk -F '->'` menjadi `awk -F '-> '`(menambahkan spasi setelah panah), sehingga saya bisa langsung menggunakan variabel hasil tanpa harus menghilangkan spasi dengan sintaks `$(echo -e "${hasil1}" | sed -e 's/^[[:space:]]*//')`

## 2. Soal 2

__Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide. Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide tersebut cepat diselesaikan. Idenya adalah kalian (a) membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka. (b) Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet. (c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal: password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28, maka akan menjadi huruf b.) dan (d) jangan lupa untuk membuat dekripsinya supaya nama file bisa kembali. HINT: enkripsi yang digunakan adalah caesar cipher. *Gunakan Bash Script__

  

Dua file script dibuat dan disimpan dalam folder `/home/stoe/PRAKTIKUM/MODUL1/`. Dua script tersebut berfungsi untuk mengenkripsi dan mendekripsi nama file, berikut script yang telah dibuat dengan nama file `soal2_enkripsi.sh` :

```bash

#!/bin/bash

  

input=$(echo $(echo $1  | awk -F '.' '{print $1}') | grep -i "^[a-z]\+$")

#echo $input

  

if [ $input ]

then

  

#=====>soal A membuat sebuah script bash yang dapat menghasilkan password secara acak

# sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka.

  

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

# echo ${arraya[hour]}-${arrayA[hour]}

#done

  

change1=${arraya[hour]}

change2=${arraya[hour2]}

change3=${arrayA[hour]}

change4=${arrayA[hour2]}

#echo $change1-$change2-$change3-$change4

#if(( hour == 22 ))

#then

# echo yes # echo $(date +"%H")

#fi

  

#=====>soal C mengenkripsi nama file yang diinputkan dengan menggunakan konversi

# huruf (string manipulation) yang disesuaikan dengan jam(0-23)

  

filename=$(echo "$input" | tr '[A-Z]' {$change3-ZA-$change4} | tr '[a-z]' {$change1-za-$change2})

#echo $filename

  

#=====>soal B Password acak tersebut disimpan pada file berekstensi.txt dengan

# nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.

  

echo  $this > "$filename".txt

  

echo  "random password telah disimpan ke dalam file bernama"  $input".txt yang telah di enkripsi :)"

  

#echo $this | tr '[A-Z]' {$change3-ZA-$change4} | tr '[a-z]' {$change1-za-$change2}

  

#decrypt=$(echo "$filename" | tr {$change3-ZA-$change4} '[A-Z]' | tr {$change1-za-$change2} '[a-z]')

#cho $decrypt

  

#read x

#if(( x=="c" ))

#then

# mv $filename.txt $decrypt.txt

# mv $thisfolder/p.test $thisfolder/ganti.test

#fi

  

else

echo  "argumen yang diinputkan dan HANYA berupa alphabet."

```

1) **Untuk soal pertama yaitu soal A, membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka.**

```bash

input=$(echo $(echo $1  | awk -F '.' '{print $1}') | grep -i "^[a-z]\+$")

#echo $input

  

if [ $input ]

then

  

#=====>soal A membuat sebuah script bash yang dapat menghasilkan password secara acak

# sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka.

  

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

# echo ${arraya[hour]}-${arrayA[hour]}

#done

  

change1=${arraya[hour]}

change2=${arraya[hour2]}

change3=${arrayA[hour]}

change4=${arrayA[hour2]}

#echo $change1-$change2-$change3-$change4

#if(( hour == 22 ))

#then

# echo yes # echo $(date +"%H")

#fi

```

  

-  `input=$(echo $(echo $1 | awk -F '.' '{print $1}') | grep -i "^[a-z]\+$")` disini saya membuat variabel input yang menyimpan argumen pertama yang hanya berupa alfabet sebelum tanda titik (.), argumen ini nantinya yang akan di enkripsi dan digunakan sebagai nama file.

- Disini saya menggunakan command `if [ $input ]` untuk menentukan percabangan dimana argumen berupa alfabet atau tidak dan apabila didalam argumen terdapat selain alfabet maka akan ditampilkan `argumen yang diinputkan dan HANYA berupa alphabet.`

-  `this=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1)` Dibuat variabel this yang berisikan sebuah tulisan random yang terdiri dari alfabet dan angka sebanyak 28 digit/huruf.

-  ` arraya=({a..z})`  `arrayA=({A..Z})` kemudian membuat dua buah array yang menyimpan huruf alfabet kapital dan huruf kecil.

-  ` hour=$(date +"%H")`  `hour2=$(($hour-1))` Membuat variabel hour yang berisi angka jam saat file dieksekusi dan hour2 yang berisi angka jam-1 saat file dieksekusi.

-  `change1=${arraya[hour]}`  `change2=${arraya[hour2]}`  `change3=${arrayA[hour]}`  `change4=${arrayA[hour2]}` Lalu membuat empat variabel yang berisi huruf dari array yang dibuat sebelumnya yang berindekskan jam.

  

2) **Soal berikutnya saya mengerjakan yang C terlebih dahulu karena diminta mengenkripsi nama file yang diinputkan dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23)**

```bash

filename=$(echo "$input" | tr '[A-Z]' {$change3-ZA-$change4} | tr '[a-z]' {$change1-za-$change2})

#echo $filename

```

-  `filename=$(echo "$input" | tr '[A-Z]' {$change3-ZA-$change4} | tr '[a-z]' {$change1-za-$change2})` Dibuat sebuah variabel filename yang menyimpan isi dari variabel input yang telah dirubah menggunakan perintah `tr`. Perintah ini akan merubah susunan sebuah kata berdasarkan urutan huruf yang diinputkan setelahnya.

  

3) **Soal B diminta Password acak yang telah dibuat disimpan pada file berekstensi.txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet dan sudah dienkripsi pada soal C.**

```bash

#=====>soal B Password acak tersebut disimpan pada file berekstensi.txt dengan

# nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.

  

echo  $this > "$filename".txt

  

echo  "random password telah disimpan ke dalam file bernama"  $input".txt yang telah di enkripsi :)"

  

#echo $this | tr '[A-Z]' {$change3-ZA-$change4} | tr '[a-z]' {$change1-za-$change2}

  

#decrypt=$(echo "$filename" | tr {$change3-ZA-$change4} '[A-Z]' | tr {$change1-za-$change2} '[a-z]')

#cho $decrypt

  

#read x

#if(( x=="c" ))

#then

# mv $filename.txt $decrypt.txt

# mv $thisfolder/p.test $thisfolder/ganti.test

#fi

```

-  `echo $this > "$filename".txt` menampilkan hasil dari variabel `this` pada soal A kedalam file yang bernama sesuai isi variabel `filename` pada soal C dengan ekstensi `.txt`

  

Berikutnya script dengan nama file `soal2_dekripsi.sh` yang sekaligus menjawab soal D.

```bash

#!/bin/bash

  

input=$(echo $(echo $1  | awk -F '.' '{print $1}') | grep -i "^[a-z]\+$")

#echo $input

  

now=`pwd`

  

#=====>soal D membuat dekripsinya supaya nama file bisa kembali.

  

if [ $input ]

then

  

#dekript

  

for  target  in  "${@}"; do

inode=$(stat -c '%i' "${target}")

fs=$(df --output=source "${target}" | tail -1)

crtime=$(sudo debugfs -R 'stat <'"${inode}"'>' "${fs}" 2>/dev/null | grep -oP 'crtime.*--\s*\K.*' | awk '{print $4}' | awk -F ':' '{print $1}')

# print1=$(echo -e "${crtime}" | sed -e 's/^[[:space:]]*//')

# echo $print1

# echo $crtime

done

  

arraya=({a..z})

arrayA=({A..Z})

  

hour=$crtime

hour2=$(($hour-1))

# echo $hour-$hour2

  

change1=${arraya[hour]}

change2=${arraya[hour2]}

change3=${arrayA[hour]}

change4=${arrayA[hour2]}

  

filename=$(echo "$input" | tr {$change3-ZA-$change4} '[A-Z]' | tr {$change1-za-$change2} '[a-z]')

  

echo  "apakah Anda ingin mendekripsi nama file yang telah dienkripsi"  $input".txt ->"  $filename.txt"?"  "Y/N"

  

read answer

if [[ $answer == "Y" ]]

then

mv "${now}/$input.txt"  "${now}/$filename.txt"

echo  "HOREE.. file"  $input".txt telah berhasil di-rename menjadi"  $filename".txt"

  

elif [[ $answer == "N" ]]

then

echo  "OK, bye.."

else

echo  "harusnya ketik "Y" atau "N" :("

fi

else

echo  "argumen yang diinputkan dan HANYA berupa alphabet dari nama file yang telah di enkripsi."

fi

```

-  `input=$(echo $(echo $1 | awk -F '.' '{print $1}') | grep -i "^[a-z]\+$")` dibuat variabel input untuk mengecek argumen, sama seperti penjelasan pada soal A dan juga apabila tidak sesuai akan mengeluarkan `argumen yang diinputkan dan HANYA berupa alphabet dari nama file yang telah di enkripsi.`

- ```bash

for  target  in  "${@}"; do

inode=$(stat -c '%i' "${target}")

fs=$(df --output=source "${target}" | tail -1)

crtime=$(sudo debugfs -R 'stat <'"${inode}"'>' "${fs}" 2>/dev/null | grep -oP 'crtime.*--\s*\K.*' | awk '{print $4}' | awk -F ':' '{print $1}')

- Kemudian dibuat sebuah looping untuk menemukan waktu file dibuat, lebih tepatnya jam file yang akan di dekripsi dibuat. Di sini saya memanfaatkan `inode` dari file tersebut untuk mencari create time-nya. Akan tetapi untuk mendapatkannya, diperlukan password dari root karena perintahnya menggunakan `sudo`.

-  `arraya=({a..z})`  `arrayA=({A..Z})`  `hour=$crtime`  `hour2=$(($hour-1))`  `change1=${arraya[hour]}`  `change2=${arraya[hour2]}`  `change3=${arrayA[hour]}`  `change4=${arrayA[hour2]}` Saya kembali membuat array alfabet, variabel hour dan variabel change seperti soal A yang sebelumya dijelaskan.

-  ` filename=$(echo "$input" | tr {$change3-ZA-$change4} '[A-Z]' | tr {$change1-za-$change2} '[a-z]')` Kembali dibuat sebuah variabel filename yang menyimpan isi dari variabel input yang telah dirubah menggunakan perintah `tr`. Perintah ini akan merubah susunan sebuah kata berdasarkan urutan huruf yang diinputkan setelahnya. Ini akan membuat variabel filename berisi nama file yang telah didekripsi.

- ```bash

echo  "apakah Anda ingin mendekripsi nama file yang telah dienkripsi"  $input".txt ->"  $filename.txt"?"  "Y/N"

  

read answer

if [[ $answer == "Y" ]]

then

mv "${now}/$input.txt"  "${now}/$filename.txt"

echo  "HOREE.. file"  $input".txt telah berhasil di-rename menjadi"  $filename".txt"

  

elif [[ $answer == "N" ]]

then

echo  "OK, bye.."

else

echo  "harusnya ketik "Y" atau "N" :("

fi

- Lalu ditampilkan sebuah pertanyaan apakah ingin mengubah nama file yang telah dienkripsi kembali ke aslinya. Jika menginput `Y` maka nama file akan dirubah, jika `N` maka sebaliknya, dan jika menginput yang lain script akan berhenti dan menampilkan sebuah tulisan.

## Revisi soal no 2.
Memecah jawaban yang enkripsi menjadi 2 bagian menjadi soal2_ab.sh dan soal2_enkripsi.sh

## 3. Soal 3

__1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma, kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing. [a] ​ Maka dari itu, kalian mencoba membuat script untuk mendownload 28 gambar dari "​ https://loremflickr.com/320/240/cat​ " menggunakan command ​ wget dan menyimpan file dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2, pdkt_kusuma_3) serta jangan lupa untuk menyimpan ​ log messages ​ wget kedalam sebuah file "wget.log"​ . Karena kalian gak suka ribet, kalian membuat penjadwalan untuk menjalankan script download gambar tersebut. Namun, script download tersebut hanya berjalan[b] ​ setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu ​ Karenagambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. [c] ​ Maka dari itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201). Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253). Setelah tidak ada gambar di ​ current directory ​ , maka lakukan backup seluruh log menjadi ekstensi ".log.bak"​ . Hint : Gunakan wget.log untuk membuat location.log yang isinya merupakan hasil dari grep "Location".__

  

File script dibuat dan disimpan dalam folder `/home/stoe/latihan/`. Script tersebut berfungsi untuk mendownload gambar dan memilahnya, berikut script yang telah dibuat dengan nama file `soal3.sh`

  

```bash

#!/bin/bash

#fungsi download

  

now=`pwd`

  

for  i  in {1..28}

do

  

#=====>soal A mendownload gambar dari link yang diberikan dan memberinya nama sesuai ketentuan..

  

wget -a wget.log "https://loremflickr.com/320/240/cat" -O pdkt_kusuma_$i

  

name1=$(grep "Location" wget.log | tail -1 | awk '{print $2}')

echo  $name1

  

if [[ ! $(ls ${now}  | grep "Location.log") && ! $(ls ${now}  | grep "duplicate") && ! $(ls ${now}  | grep "kenangan") ]]

then

touch Location.log

mkdir duplicate kenangan

fi

  

#=====>soal C mengidentifikasi gambar yang identik dari gambar yang didownload tadi serta

# mengubah namanya menjadi duplicate_nomor apabila identik dan memasukannya ke folder duplicate atau

# mengubah namanya menjadi kenangan_nomor apabila tidak identik dan memasukannya ke folder kenangan

  

if [[ $(grep "$name1" Location.log) ]]

then

echo aye

count1=$(ls duplicate/ |awk -F '_' '{print $2}' | sort -rn | head -1)

  

if [[ $count1 ]]

then

mv "${now}/pdkt_kusuma_$i"  "${now}/duplicate/duplicate_$(($count1+1))"

else

mv "${now}/pdkt_kusuma_$i"  "${now}/duplicate/duplicate_1"

fi

else

echo nope

count2=$(ls kenangan/ |awk -F '_' '{print $2}' | sort -rn | head -1)

  

if [[ $count2 ]]

then

mv "${now}/pdkt_kusuma_$i"  "${now}/kenangan/kenangan_$(($count2+1))"

else

mv "${now}/pdkt_kusuma_$i"  "${now}/kenangan/kenangan_1"

fi

  

echo  $name1 >> Location.log

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

# echo aye

#else

# echo nope

#fi

  

#grep "Location" log.log > location.log

```

- Dibuat variabel `now` untuk menyimpan lokasi saat ini.

-  `for i in {1..28} do` Dibuat looping yang akan berputar sebanyak 28 kali.

  

1) **soal A diperintahkan mendownload gambar dari link yang diberikan dan memberinya nama sesuai ketentuan..**

```bash

wget -a wget.log "https://loremflickr.com/320/240/cat" -O pdkt_kusuma_$i

  

name1=$(grep "Location" wget.log | tail -1 | awk '{print $2}')

echo  $name1

  

if [[ ! $(ls ${now}  | grep "Location.log") && ! $(ls ${now}  | grep "duplicate") && ! $(ls ${now}  | grep "kenangan") ]]

then

touch Location.log

mkdir duplicate kenangan

fi

```

-  `wget -a wget.log "https://loremflickr.com/320/240/cat" -O pdkt_kusuma_$i` Membuat perintah yang mendownload gambar sesuai dengan link yang diberikan dan menyimpan log-nya kedalam file `wget.log` dan mengubah nama file yang di download menjadi `pdkt_kusuma_$i`.

-  `name1=$(grep "Location" wget.log | tail -1 | awk '{print $2}') echo $name1` mengambil `Location` download terakhir dari file `wget.log` dan menyimpannya ke dalam variabel `name1`.

- ``` bash

if [[ ! $(ls ${now}  | grep "Location.log") && ! $(ls ${now}  | grep "duplicate") && ! $(ls ${now}  | grep "kenangan") ]]

then

touch Location.log

mkdir duplicate kenangan

fi

- Mengecek apabila file `Location.log`, folder `duplicate`, dan `kenangan` atau salah satunya tidak ada maka akan dibuat file atau foldernya.

2) **soal C mengidentifikasi gambar yang identik dari gambar yang didownload tadi serta mengubah namanya menjadi duplicate_nomor apabila identik dan memasukannya ke folder duplicate atau mengubah namanya menjadi kenangan_nomor apabila tidak identik dan memasukannya ke folder kenangan**

  

```bash

  

if [[ $(grep "$name1" Location.log) ]]

then

echo aye

count1=$(ls duplicate/ |awk -F '_' '{print $2}' | sort -rn | head -1)

  

if [[ $count1 ]]

then

mv "${now}/pdkt_kusuma_$i"  "${now}/duplicate/duplicate_$(($count1+1))"

else

mv "${now}/pdkt_kusuma_$i"  "${now}/duplicate/duplicate_1"

fi

else

echo nope

count2=$(ls kenangan/ |awk -F '_' '{print $2}' | sort -rn | head -1)

  

if [[ $count2 ]]

then

mv "${now}/pdkt_kusuma_$i"  "${now}/kenangan/kenangan_$(($count2+1))"

else

mv "${now}/pdkt_kusuma_$i"  "${now}/kenangan/kenangan_1"

fi

  

echo  $name1 >> Location.log

fi

  

done

  

# setelah proses download dan pemilahan selesai, serta tidak ada gambar di current directory,

# maka maka lakukan backup seluruh log message menjadi ekstensi .log.bak

cat wget.log >> wget.log.bak

> wget.log

```

-  `if [[ $(grep "$name1" Location.log) ]]` Mengecek apabila ditemukan lokasi yang sama antara lokasi yang diambil dari `wget.log` terakhir dengan lokasi pada `Location.log` maka akan menjalankan program selanjutnya, jika tidak sama maka akan masuk else.

-  `count1=$(ls duplicate/ |awk -F '_' '{print $2}' | sort -rn | head -1)` membuat variabel `count1` yang berisi angka terakhir pada gambar file duplicate.

- ```bash

if [[ $count1 ]]

then

mv "${now}/pdkt_kusuma_$i"  "${now}/duplicate/duplicate_$(($count1+1))"

else

mv "${now}/pdkt_kusuma_$i"  "${now}/duplicate/duplicate_1"

fi

- Dicek apabila variabel `count1` memiliki nilai maka file yang didownload akan berubah menjadi duplicate dengan nomor melanjutkan nomor pada variabel `count1` serta dipindahkan ke folder duplicate dan jika tidak memiliki nilai maka nama filenya berubah menjadi `duplicate_1` dan dipindahkan juga ke folder duplicate.

-  `count2=$(ls kenangan/ |awk -F '_' '{print $2}' | sort -rn | head -1)` Disini program memasuki `else` dan dibuat variabel `count2` yang menyimpan angka terakhir pada gambar file kenangan.

- ```bash

if [[ $count2 ]]

then

mv "${now}/pdkt_kusuma_$i"  "${now}/kenangan/kenangan_$(($count2+1))"

else

mv "${now}/pdkt_kusuma_$i"  "${now}/kenangan/kenangan_1"

fi

- Dicek apabila variabel `count2` memiliki nilai maka file yang didownload akan berubah menjadi kenangan dengan nomor melanjutkan nomor pada variabel `count2` serta dipindahkan ke folder kenangan dan jika tidak memiliki nilai maka nama filenya berubah menjadi `kenangan_1` dan dipindahkan juga ke folder kenangan.

-  `echo $name1 >> Location.log` Menampilkan lokasi yang berada di variabel `name1` dan menyimpannya ke dalam file `Location.log`

-  `cat wget.log >> wget.log.bak` Memindahkan isi file `wget.log` ke file `wget.log.bak` tanpa menghapus data pada file `wget.log.bak`.

-  `> wget.log` Menghapus isi file `wget.log`

3) **Soal B diminta untuk menjalankan program setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu**

  

```bash

# Edit this file to introduce tasks to be run by cron.

#

# Each task to run has to be defined through a single line

# indicating with different fields when the task will be run

# and what command to run for the task

#

# To define the time you can provide concrete values for

# minute (m), hour (h), day of month (dom), month (mon),

# and day of week (dow) or use '*' in these fields (for 'any').#

# Notice that tasks will be started based on the cron's system

# daemon's notion of time and timezones.

#

# Output of the crontab jobs (including errors) is sent through

# email to the user the crontab file belongs to (unless redirected).

#

# For example, you can run a backup of all your user accounts

# at 5 a.m every week with:

# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/

#

# For more information see the manual pages of crontab(5) and cron(8)

#

# m h dom mon dow command

#

5 6,14,22 * * SUN-FRI cd /home/stoe/latihan && /bin/bash /home/stoe/latihan/soal3.sh

```

-  `5 6,14,22 * * SUN-FRI cd` program dijalankan pada menit ke 5, jam ke 6,14,dan 22, setiap hari dari hari Minggu sampai Jumat kecuali hari Sabtu.

-  `cd /home/stoe/latihan` Sebelum menjalankan perintah script, digunakan perintah cd untuk berpindah tempat ke `/home/stoe/latihan` agar file yaang di download tidak berada di folder `/home/stoe`.

-  `/bin/bash /home/stoe/latihan/soal3.sh` mejalankan bash script sesuai dengan full path yang diberikan.

## Revisi soal no 3.
Apabila crontab tidak menggunakan perintah cd terlebih dahulu maka file yang di download akan disimpan secara default di home user dimana crontab itu dijalankan.
