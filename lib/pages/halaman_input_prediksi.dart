import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/prediksi_model.dart';
import 'halaman_hasil_prediksi.dart';

class InputPrediksi extends StatefulWidget {
  const InputPrediksi({super.key, this.onViewStatistics});

  final VoidCallback? onViewStatistics;

  @override
  State<InputPrediksi> createState() => _InputPrediksiState();
}

class _InputPrediksiState extends State<InputPrediksi> {
  final _formKey = GlobalKey<FormState>();
  final _prediksiSuhuController = TextEditingController();
  final _prediksiKelembabanUdaraController = TextEditingController();
  final _prediksiKelembabanTanahController = TextEditingController();
  final _namaPetugasController = TextEditingController();
  String? _petakTerpilih;
  String? _namaTanamanTerpilih;

  @override
  void dispose() {
    _prediksiSuhuController.dispose();
    _prediksiKelembabanUdaraController.dispose();
    _prediksiKelembabanTanahController.dispose();
    _namaPetugasController.dispose();
    super.dispose();
  }

  Future<void> _simpanPrediksi() async {
    if (!_formKey.currentState!.validate()) return;

    final prediksi = Prediksi(
      petak: _petakTerpilih!,
      namaTanaman: _namaTanamanTerpilih!,
      prediksiSuhu: _prediksiSuhuController.text.trim(),
      prediksiKelembabanUdara:
          _prediksiKelembabanUdaraController.text.trim(),
      prediksiKelembabanTanah:
          _prediksiKelembabanTanahController.text.trim(),
      namaPetugas: _namaPetugasController.text.trim(),
    );

    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Data Prediksi'),
        content: Text(
          'Simpan prediksi ${prediksi.namaTanaman} di ${prediksi.petak}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Periksa Kembali'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ya, Simpan'),
          ),
        ],
      ),
    );
    if (konfirmasi != true || !mounted) return;

    context.read<PrediksiModel>().tambah(prediksi);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HalamanHasilPrediksi(
          prediksi: prediksi,
          onViewStatistics: widget.onViewStatistics,
        ),
      ),
    );
  }

  String? _wajibDiisi(String? nilai) {
    if (nilai == null || nilai.trim().isEmpty) {
      return 'Bagian ini wajib diisi';
    }
    return null;
  }

  String? _validasiAngka(String? nilai) {
    if (nilai == null || nilai.trim().isEmpty) {
      return 'Bagian ini wajib diisi';
    }
    final angka = double.tryParse(nilai.trim());
    if (angka == null || !angka.isFinite) {
      return 'Masukkan angka yang valid';
    }
    return null;
  }

  String? _validasiKelembaban(String? nilai) {
    final kesalahanAngka = _validasiAngka(nilai);
    if (kesalahanAngka != null) return kesalahanAngka;
    final angka = double.parse(nilai!.trim());
    if (angka < 0 || angka > 100) {
      return 'Nilai kelembaban harus antara 0 dan 100';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Prediksi')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            FormField<String>(
              initialValue: _petakTerpilih,
              validator: (nilai) =>
                  nilai == null ? 'Pilih petak terlebih dahulu' : null,
              builder: (field) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Petak'),
                  RadioListTile<String>(
                    title: const Text('Petak 1'),
                    value: 'Petak 1',
                    groupValue: field.value,
                    onChanged: (nilai) {
                      field.didChange(nilai);
                      setState(() => _petakTerpilih = nilai);
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Petak 2'),
                    value: 'Petak 2',
                    groupValue: field.value,
                    onChanged: (nilai) {
                      field.didChange(nilai);
                      setState(() => _petakTerpilih = nilai);
                    },
                  ),
                  if (field.hasError)
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        field.errorText!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _namaTanamanTerpilih,
              decoration: const InputDecoration(
                labelText: 'Nama Tanaman',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Padi', child: Text('Padi')),
                DropdownMenuItem(value: 'Jagung', child: Text('Jagung')),
                DropdownMenuItem(value: 'Cabai', child: Text('Cabai')),
              ],
              validator: (nilai) =>
                  nilai == null ? 'Pilih nama tanaman terlebih dahulu' : null,
              onChanged: (nilai) =>
                  setState(() => _namaTanamanTerpilih = nilai),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _prediksiSuhuController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Prediksi Suhu Udara (°C)',
                border: OutlineInputBorder(),
              ),
              validator: _validasiAngka,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _prediksiKelembabanUdaraController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Prediksi Kelembaban Udara (%)',
                border: OutlineInputBorder(),
              ),
              validator: _validasiKelembaban,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _prediksiKelembabanTanahController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Prediksi Kelembaban Tanah (%)',
                border: OutlineInputBorder(),
              ),
              validator: _validasiKelembaban,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _namaPetugasController,
              decoration: const InputDecoration(
                labelText: 'Nama Petugas',
                border: OutlineInputBorder(),
              ),
              validator: _wajibDiisi,
            ),
            FilledButton.icon(
              onPressed: _simpanPrediksi,
              icon: const Icon(Icons.check),
              label: const Text('Simpan dan Lihat Hasil'),
            ),
          ],
        ),
      ),
    );
  }
}
