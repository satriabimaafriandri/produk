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
| <img src="https://raw.githubusercontent.com/satriabimaafriandri/produk/main/screenshots/dashboard.gif" width="200" alt="Dashboard"> | <img src="https://raw.githubusercontent.com/satriabimaafriandri/produk/main/screenshots/add_product.gif" width="200" alt="Tambah"> | <img src="https://raw.githubusercontent.com/satriabimaafriandri/produk/main/screenshots/detail.gif" width="200" alt="Detail"> |
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
