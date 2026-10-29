import 'package:flutter/material.dart';

import '../model/prediksi_model.dart';

class HalamanHasilPrediksi extends StatelessWidget {
  const HalamanHasilPrediksi({
    super.key,
    required this.prediksi,
    this.onViewStatistics,
  });

  final Prediksi prediksi;
  final VoidCallback? onViewStatistics;

  @override
  Widget build(BuildContext context) {
    String statusKelembaban(String nilai) {
      final kelembaban = double.parse(nilai);
      if (kelembaban < 40) return 'Kering';
      if (kelembaban <= 70) return 'Optimal';
      return 'Terlalu lembab';
    }

    String rekomendasiKelembaban(String nilai, String parameter) {
      switch (statusKelembaban(nilai)) {
        case 'Kering':
          return parameter == 'tanah'
              ? 'Periksa kondisi tanaman dan pertimbangkan penyiraman.'
              : 'Kelembaban udara rendah; pantau kondisi tanaman.';
        case 'Optimal':
          return 'Kondisi kelembaban optimal. Pertahankan pola perawatan.';
        case 'Terlalu lembab':
          return parameter == 'tanah'
              ? 'Kurangi penyiraman dan pastikan drainase berjalan baik.'
              : 'Pastikan sirkulasi udara baik untuk mengurangi kelembaban.';
        default:
          return '';
      }
    }

    final data = <(String, String)>[
      ('Petak', prediksi.petak),
      ('Nama Tanaman', prediksi.namaTanaman),
      ('Suhu Udara', '${prediksi.prediksiSuhu} °C'),
      ('Kelembaban Udara', '${prediksi.prediksiKelembabanUdara} %'),
      (
        'Status Kelembaban Udara',
        statusKelembaban(prediksi.prediksiKelembabanUdara),
      ),
      (
        'Rekomendasi Kelembaban Udara',
        rekomendasiKelembaban(prediksi.prediksiKelembabanUdara, 'udara'),
      ),
      ('Kelembaban Tanah', '${prediksi.prediksiKelembabanTanah} %'),
      (
        'Status Kelembaban Tanah',
        statusKelembaban(prediksi.prediksiKelembabanTanah),
      ),
      (
        'Rekomendasi Kelembaban Tanah',
        rekomendasiKelembaban(prediksi.prediksiKelembabanTanah, 'tanah'),
      ),
      ('Nama Petugas', prediksi.namaPetugas),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Prediksi')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: data.length + 4,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Icon(Icons.task_alt, size: 64, color: Colors.green),
            );
          }
          if (index == 1) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Hasil berdasarkan data yang Anda masukkan',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          }
          if (index >= 2 && index < data.length + 2) {
            final item = data[index - 2];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Icon(
                  Icons.eco_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(item.$1),
                subtitle: Text(item.$2),
              ),
            );
          }
          if (index == data.length + 2) {
            return Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: FilledButton.icon(
                onPressed: () {
                  onViewStatistics?.call();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.bar_chart),
                label: const Text('Lihat Statistik'),
              ),
            );
          }
          return OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.edit),
            label: const Text('Kembali ke Formulir'),
          );
        },
      ),
    );
  }
}
