# Perubahan AgriClima

- Menambahkan `TemaCubit` menggunakan `flutter_bloc` untuk mengelola tema, sesuai pola Cubit pada materi Modul 6.
- `MaterialApp` menggunakan `BlocBuilder<TemaCubit, ThemeMode>` serta `theme`, `darkTheme`, dan `themeMode` sehingga tema terang/gelap diterapkan ke seluruh aplikasi.
- Bottom navigation memiliki halaman Pengaturan yang terhubung ke `HalamanPengaturan`.
- Halaman Pengaturan menggunakan `BlocBuilder` dan menyediakan switch untuk mengubah tema terang dan gelap.
- Halaman Hasil Prediksi memakai `ListView.builder` untuk menampilkan setiap nilai dari objek `Prediksi` yang dibuat dari input formulir.
- Tombol Tentang Aplikasi membuka route Tentang, bukan mengalihkan pengguna ke Pengaturan.

## Menjalankan
1. Ekstrak ZIP.
2. Buka folder proyek di VS Code atau Android Studio.
3. Jalankan `flutter pub get`.
4. Jalankan `flutter analyze`.
5. Jalankan `flutter run`.

Catatan: pemeriksaan `flutter analyze` dan `flutter run` belum dapat dijalankan di lingkungan pengerjaan ini karena Flutter SDK tidak tersedia.
