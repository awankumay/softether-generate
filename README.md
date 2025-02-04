# Softether Certificate Generate

Skrip Bash untuk Generate Certificate Softether

## Deskripsi

Script ini digunakan untuk menghasilkan sertifikat X509 (.cer dan .key) dan mengkonversinya ke format PKCS#12 (.p12) dengan passcode yang dapat dimasukkan secara manual atau dihasilkan secara otomatis. Passcode akan disimpan dalam file `passcode-$username.txt` di direktori pengguna yang sesuai.

## Prasyarat

- OpenSSL harus terinstal di sistem Anda.
- Script ini harus dijalankan di lingkungan bash.

## Cara Menjalankan Skrip

1. **Siapkan File Sertifikat**: Pastikan Anda memiliki file `.pem` yang diperlukan di direktori saat ini. Script akan mencari file dengan ekstensi `.pem`.

2. **Jalankan Script**:

   - Buka terminal.
   - Navigasikan ke direktori tempat script disimpan.
   - Jalankan script dengan perintah:

     ```bash
     bash generate-tools.sh
     ```

3. **Masukkan Nama Pengguna**: Ketika diminta, masukkan nama pengguna yang akan digunakan sebagai Common Name (CN) untuk sertifikat.

4. **Pilih Certfile**: Script akan menampilkan daftar file `.pem` yang ditemukan di direktori saat ini. Masukkan nomor file yang ingin Anda gunakan sebagai certfile.

5. **Masukkan Passcode**: Anda akan diminta untuk memasukkan passcode. Jika Anda tidak ingin memasukkan passcode, cukup tekan Enter, dan script akan menghasilkan passcode secara otomatis.

6. **Simpan Passcode**: Passcode yang digunakan (baik yang dimasukkan atau yang dihasilkan) akan disimpan dalam file `passcode-$username.txt` di direktori pengguna yang sesuai.

7. **Selesai**: Setelah proses selesai, Anda akan mendapatkan file sertifikat `.cer`, kunci `.key`, dan file PKCS#12 `.p12` di dalam direktori pengguna yang telah dibuat.

## Mengedit Detail Sertifikat

Anda dapat mengedit detail sertifikat yang dihasilkan dengan mengubah variabel berikut dalam script:

- `O`: Nama organisasi (Organization).
- `OU`: Nama unit organisasi (Organizational Unit).
- `C`: Kode negara (Country).
- `ST`: Nama provinsi atau negara bagian (State).

Contoh:

```bash
# Detail sertifikat
O="Example Corporate"
OU="Corporate"
C="ID"
ST="Jakarta"
```

Ubah nilai-nilai tersebut sesuai kebutuhan Anda sebelum menjalankan script.

Support :

Windows ✅
MacOS ✅