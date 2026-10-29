import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key, this.onNavigate});

  final ValueChanged<int>? onNavigate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AgriClima - Beranda')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          children: [
            Text(
              'Selamat Datang di AgriClima LSTM',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'Aplikasi untuk mencatat hasil prediksi mikroklimat tanaman di '
              'lahan Kelompok Tani Sri Mulya, agar kebutuhan penyiraman tiap '
              'petak mudah dipantau.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Card(
              key: const ValueKey('beranda-info-card'),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Model: LSTM (Deep Learning)',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Prediksi 24 jam ke depan \nuntuk suhu udara, '
                            'kelembaban udara, dan kelembaban tanah.',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.tentang),
              child: const Text('Tentang Aplikasi'),
            ),
          ],
        ),
      ),
    );
  }
}
