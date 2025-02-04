#!/bin/bash

# Meminta input dari pengguna untuk nama pengguna
read -p "Masukkan Nama Pengguna (CN): " username

# Definisikan base_path berdasarkan nama pengguna
base_path="./$username"

# Memastikan path untuk base_path ada
if [ ! -d "./" ]; then
  echo "Error: Path ./ tidak ditemukan."
  exit 1
fi

# Mencari file .pem di direktori saat ini
pem_files=(*.pem)
pem_count=${#pem_files[@]}

# Memeriksa apakah ada file .pem
if [ $pem_count -eq 0 ]; then
  echo "Error: Tidak ada file .pem ditemukan di direktori saat ini."
  exit 1
fi

# Menampilkan daftar file .pem
echo "Daftar file .pem yang ditemukan:"
for i in "${!pem_files[@]}"; do
  echo "$((i + 1)). ${pem_files[i]}"
done

# Meminta pengguna untuk memilih certfile
read -p "Masukkan nomor certfile yang ingin digunakan: " certfile_choice

# Memeriksa pilihan pengguna
if [[ ! $certfile_choice =~ ^[0-9]+$ ]] || [ $certfile_choice -lt 1 ] || [ $certfile_choice -gt $pem_count ]; then
  echo "Error: Pilihan tidak valid."
  exit 1
fi

# Menentukan certfile berdasarkan pilihan pengguna
certfile="${pem_files[$((certfile_choice - 1))]}"

# Memeriksa apakah direktori user ada, jika tidak ada maka buat direktori baru
if [ ! -d "$base_path" ]; then
  mkdir -p "$base_path"
fi

# Meminta input dari pengguna untuk passcode
read -s -p "Masukkan Passcode (kosongkan untuk menggunakan passcode default): " password
echo

# Jika passcode tidak dimasukkan, gunakan passcode default
if [ -z "$password" ]; then
  password=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c8 ; echo '')
  echo "Passcode default yang digunakan: $password"
fi

# Simpan passcode ke dalam file
echo "$password" > "$base_path/passcode-$username.txt"
echo "Passcode disimpan di $base_path/passcode-$username.txt"

# Detail sertifikat
O="Example Corporate"
OU="Corporate"
C="ID"
ST="Jakarta"

# Generate sertifikat X509 (.cer dan .key) dengan passcode
openssl req -x509 -newkey rsa:2048 -keyout "$base_path/${username}.key" -out "$base_path/${username}.cer" -days 90 -nodes -passout pass:"$password" -subj "/CN=$username/O=$O/OU=$OU/C=$C/ST=$ST"

if [ $? -eq 0 ]; then
  echo "Berhasil menghasilkan sertifikat X509 untuk $username."
else
  echo "Gagal menghasilkan sertifikat X509 untuk $username."
  exit 1
fi

# Konversi sertifikat ke format PKCS#12
openssl pkcs12 -export -legacy -in "$base_path/${username}.cer" -inkey "$base_path/${username}.key" -certfile "$certfile" -name "$username" -out "$base_path/${username}.p12" -passout pass:"$password"

if [ $? -eq 0 ]; then
  echo "Berhasil menghasilkan file PKCS#12 untuk $username: $base_path/${username}.p12"
else
  echo "Gagal menghasilkan file PKCS#12 untuk $username."
  exit 1
fi
