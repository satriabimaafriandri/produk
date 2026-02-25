# 📱 CRUD Data Siswa (Flutter Product Project)

[![Flutter Version](https://img.shields.io/badge/Flutter-v3.24+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-v3.0+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Maintainer](https://img.shields.io/badge/Maintainer-satriabimaafriandri-indigo)](https://github.com/satriabimaafriandri)

Aplikasi manajemen data siswa yang modern dengan antarmuka pengguna (UI) yang elegan menggunakan Flutter. Proyek ini mencakup integrasi API untuk operasi Create, Read, Update, dan Delete (CRUD).

---

## ✨ Fitur Utama
* **Modern Dashboard**: Tampilan daftar siswa dengan kartu profil yang estetik.
* **Dynamic Form**: Input data siswa yang divalidasi dengan antarmuka responsif.
* **Profile Header Detail**: Detail siswa dengan desain profil melengkung dan tombol aksi yang cepat.
* **Real-time Feedback**: Notifikasi snackbar dan indikator loading yang animatif.

---

## 📸 Preview Output

| 📊 Dashboard Utama | 📝 Tambah Produk/Siswa | 👤 Detail & Profil |
| :---: | :---: | :---: |
| <img width="1919" height="1079" alt="Screenshot 2026-02-24 080738" src="https://github.com/user-attachments/assets/62b608ef-e725-4b8d-8680-72723e55e6f5" />
 | <img width="1919" height="1079" alt="Screenshot 2026-02-24 080930" src="https://github.com/user-attachments/assets/2c85283b-46a7-49ce-8c30-02e1241e6df2" />
 | <img width="1919" height="1079" alt="Screenshot 2026-02-24 080906" src="https://github.com/user-attachments/assets/4e0e6881-9378-4572-b85f-cd65dd041270" />
 |
| *Modern Card List* | *Validated Form* | *Profile Header UI* |

> **Catatan:** Ganti link gambar di atas dengan screenshot asli kamu yang ada di folder `screenshots` repository agar muncul secara otomatis.

---

## 🚀 Teknologi yang Digunakan

* **Framework**: [Flutter](https://flutter.dev)
* **Language**: [Dart](https://dart.dev)
* **HTTP Client**: `http` package untuk koneksi API.
* **Backend**: PHP & MySQL (via `${Api.baseUrl}`)

---

## 🛠️ Instalasi & Persiapan

1.  **Clone Repository**
    ```bash
    git clone [https://github.com/satriabimaafriandri/produk.git](https://github.com/satriabimaafriandri/produk.git)
    cd produk
    ```

2.  **Install Dependencies**
    ```bash
    flutter pub get
    ```

3.  **Konfigurasi API**
    Buka file `lib/models/api.dart` dan sesuaikan `baseUrl` dengan server lokal atau hosting kamu.

4.  **Jalankan Aplikasi**
    ```bash
    flutter run
    ```

---

## 📂 Struktur Folder Utama
```text
lib/
 ├── models/     # Model data & konfigurasi API
 ├── ui/         # Semua halaman (Dashboard, Form, Detail)
 └── main.dart   # Titik awal aplikasi
