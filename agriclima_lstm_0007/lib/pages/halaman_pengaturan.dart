import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/tema_cubit.dart';

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AgriClima - Pengaturan')),
      body: BlocBuilder<TemaCubit, ThemeMode>(
        builder: (context, mode) {
          final temaGelapAktif = mode == ThemeMode.dark;
          final warna = Theme.of(context).colorScheme;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Tampilan', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Card(
                child: SwitchListTile(
                  secondary: Icon(
                    temaGelapAktif ? Icons.dark_mode : Icons.light_mode,
                    color: warna.primary,
                  ),
                  title: const Text('Tema gelap'),
                  subtitle: Text(
                    temaGelapAktif
                        ? 'Tema gelap sedang digunakan'
                        : 'Tema terang sedang digunakan',
                  ),
                  value: temaGelapAktif,
                  onChanged: context.read<TemaCubit>().aturTemaGelap,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: ListTile(
                  leading: Icon(Icons.palette_outlined, color: warna.primary),
                  title: const Text('Tema aplikasi'),
                  subtitle: Text(temaGelapAktif ? 'Gelap' : 'Terang'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
