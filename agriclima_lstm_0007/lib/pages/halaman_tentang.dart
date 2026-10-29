import 'package:flutter/material.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key, this.judul, this.keterangan});

  final String? judul;
  final String? keterangan;

  @override
  Widget build(BuildContext context) {
    final parameter = [
      ('Suhu udara', '°C', Icons.thermostat_outlined),
      ('Kelembaban udara', '%', Icons.water_drop_outlined),
      ('Kelembaban tanah', '%', Icons.grass_outlined),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(judul ?? 'AgriClima - Tentang')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'AgriClima LSTM',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tujuan Aplikasi',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    keterangan ??
                        'AgriClima LSTM membantu memantau mikroklimat tanaman '
                            'dan melihat prediksi 24 jam ke depan agar '
                            'kebutuhan penyiraman tiap petak lebih mudah '
                            'ditentukan.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'Lokasi Pemantau',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.location_on_outlined),
                  title: Text('Kelompok Tani Sri Mulya'),
                  subtitle: Text('Petak 1'),
                ),
                const ListTile(
                  leading: Icon(Icons.location_on_outlined),
                  title: Text('Kelompok Tani Sri Mulya'),
                  subtitle: Text('Petak 2'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'Parameter Mikroklimat',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                for (final (nama, satuan, ikon) in parameter)
                  ListTile(
                    leading: Icon(ikon),
                    title: Text(nama),
                    trailing: Text(satuan),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
