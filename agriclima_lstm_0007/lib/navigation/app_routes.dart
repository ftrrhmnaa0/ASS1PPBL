import 'package:flutter/material.dart';

import '../model/prediksi_model.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_input_prediksi.dart';
import '../pages/halaman_tentang.dart';
import '../pages/statistik_page.dart';

class AppRoutes {
 static const String beranda = '/beranda';
 static const String tentang = '/tentang';
 static const String inputPrediksi = '/input-prediksi';
 static const String hasilPrediksi = '/hasil-prediksi';
 static const String statistik = '/statistik';

 static Map<String, WidgetBuilder> daftarRoute() {
   return {
     beranda: (context) => const HalamanBeranda(),
     inputPrediksi: (context) => const InputPrediksi(),
     statistik: (context) => const StatistikPage(),
   };
 }

 static Route<dynamic>? bentukRoute(RouteSettings settings) {
   if (settings.name == tentang) {
     final argumen = settings.arguments;
     final data = argumen is Map ? argumen : const {};
     return MaterialPageRoute(
       settings: settings,
       builder: (context) => HalamanTentang(
         judul: data['judul'] is String ? data['judul'] as String : null,
         keterangan:
             data['keterangan'] is String ? data['keterangan'] as String : null,
       ),
     );
   }

   return null;
 }

 static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
   return MaterialPageRoute(
     settings: settings,
     builder: (context) => Scaffold(
       appBar: AppBar(title: const Text('Halaman Tidak Ditemukan')),
       body: Center(child: Text('Route ${settings.name} belum terdaftar.')),
     ),
   );
 }
}

class _KesalahanArgumenRoute extends StatelessWidget {
 const _KesalahanArgumenRoute();

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: const Text('Hasil Prediksi')),
     body: const Center(
       child: Text('Data prediksi tidak tersedia. Silakan isi formulir lagi.'),
     ),
   );
 }
}
