import 'package:flutter/foundation.dart';
class Prediksi {
 final String petak;
 final String namaTanaman;
 final String prediksiSuhu;
 final String prediksiKelembabanUdara;
 final String prediksiKelembabanTanah;
 final String namaPetugas;
 Prediksi({required this.petak, required this.namaTanaman, required this.prediksiSuhu, required this.prediksiKelembabanUdara, required this.prediksiKelembabanTanah, required this.namaPetugas});
}

class PrediksiModel extends ChangeNotifier {
 final List<Prediksi> _daftar = [];
 List<Prediksi> get daftar => List.unmodifiable(_daftar);
 void tambah(Prediksi prediksi) {
 _daftar.add(prediksi);
 notifyListeners();
 }
 int jumlahSesi(String petak) => _daftar.where((p) => p.petak == petak).length;
}
