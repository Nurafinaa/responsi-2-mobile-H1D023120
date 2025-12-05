# Responsi 2 Mobile H1D023120
## Nama : Nurafina Nazwani
## Shift Baru : D
## Shift Awal : A
### dokumentasi Aplikasi : https://drive.google.com/drive/folders/1GhFQjuwssMm2mKaonvg4giLcs9GxpeRj?usp=drive_link

aplikasi mobile ini adalah aplikasi untuk mengelola inventaris toko, dibuat dengan Flutter dan terhubung ke API backend. Aplikasi ini memungkinkan pengguna untuk melakukan CRUD inventaris, mengelola akun melalui login/registrasi, serta menampilkan data inventaris. dengan penjelasan sebagai berikut:

# API Inventaris Nazwamart

##  API Endpoints

### Autentikasi
- **POST /registrasi** → Daftar user baru  
- **POST /login** → Login user  

### Inventaris
- **GET /inventaris** → List semua item  
- **GET /inventaris/{id}** → Detail item  
- **POST /inventaris** → Tambah item  
- **PUT /inventaris/{id}** → Update item  
- **DELETE /inventaris/{id}** → Hapus item  

---

## Backend Structure

### Database Config
**File:** `app/Config/Database.php`  
`hostname = localhost`  
`database = makanan_api`  

### Models
- **UserModel** → users table  
  `allowedFields = ['nama', 'email', 'password']`  
- **InventarisModel** → inventaris table  
  `allowedFields = ['nama', 'harga', 'jumlah', 'tanggal_masuk', 'tanggal_kedaluwarsa']`  

### Controllers
- **Registrasi** → Validasi → Hash password → Simpan (`password_hash`)  
- **Login** → Cek email → Verifikasi password → Return data (`password_verify`)  
- **CRUD Inventaris**  
  - `index()` → List semua  
  - `show($id)` → Detail  
  - `create()` → Tambah  
  - `update($id)` → Update  
  - `delete($id)` → Hapus  

---

# Penjelasan Flutter

### 1. BLoC (Business Logic Component)

- **inventaris_bloc.dart**  
  Mengelola semua operasi CRUD untuk data inventaris:
  - `getInventaris()`: Mengambil semua data inventaris dari API
  - `addInventaris()`: Menambah item inventaris baru
  - `updateInventaris()`: Mengupdate data inventaris yang sudah ada
  - `deleteInventaris()`: Menghapus item inventaris berdasarkan ID

- **login_bloc.dart**  
  Menangani proses login pengguna.

- **logout_bloc.dart**  
  Menangani proses logout dengan menghapus semua data pengguna dari local storage.

- **registrasi_bloc.dart**  
  Menangani pendaftaran pengguna baru.

---

### 2. Helpers

- **api_url.dart**: Menyimpan semua URL endpoint API (base URL + endpoint CRUD).  
- **api.dart**: Class helper untuk HTTP request (`get`, `post`, `put`, `delete`).  
- **user_info.dart**: Mengelola data pengguna menggunakan SharedPreferences.  
- **app_exception.dart**: Menangani error saat berkomunikasi dengan API.

---

### 3. Model

- **inventaris.dart**: Model data item inventaris (id, nama, harga, jumlah, tanggal masuk, tanggal kedaluwarsa)  
  - `fromJson()`, `toJson()`  
- **login.dart**: Model untuk response login dari API.  
- **registrasi.dart**: Model untuk response registrasi dari API.

---

### 4. UI (User Interface)

- **login_page.dart**: Halaman login dengan form email & password, tombol login, dan link registrasi.  
- **registrasi_page.dart**: Halaman registrasi dengan form nama, email, password, validasi input, dan tombol registrasi.  
- **inventaris_page.dart**: Halaman daftar inventaris:
  - List item inventaris dengan nama, jumlah, harga
  - Floating Action Button untuk tambah item baru
  - Pull-to-refresh
  - Drawer menu untuk logout
  - Klik item → detail

- **inventaris_detail.dart**: Halaman detail item:
  - Informasi lengkap item
  - Tombol Edit & Hapus (dengan konfirmasi)
  - Fungsi format angka & tanggal

- **inventaris_form.dart**: Halaman form tambah/edit item:
  - Field nama, harga, jumlah, tanggal masuk, tanggal kedaluwarsa
  - Validasi wajib diisi
  - Loading indicator & notifikasi sukses/gagal

---

### 5. Widget

- **success_dialog.dart**: Dialog notifikasi sukses (hijau)  
- **warning_dialog.dart**: Dialog notifikasi error (merah)

---

### 6. main.dart

- Entry point aplikasi
- Mengecek status login:
  - Token ada → InventarisPage
  - Token tidak ada → LoginPage
- SplashScreen loading pertama kali buka aplikasi
- Konfigurasi tema (Material Design 3, hijau, border radius 16px)
