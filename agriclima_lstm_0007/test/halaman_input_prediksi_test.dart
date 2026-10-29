import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:agriclima_lstm_0007/model/prediksi_model.dart';
import 'package:agriclima_lstm_0007/pages/halaman_input_prediksi.dart';

Future<void> _pumpHalamanInput(WidgetTester tester, PrediksiModel model) async {
  tester.view.physicalSize = const Size(900, 2000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ChangeNotifierProvider.value(
      value: model,
      child: const MaterialApp(home: InputPrediksi()),
    ),
  );
}

Future<void> _isiField(WidgetTester tester, String label, String nilai) async {
  final field = find.widgetWithText(TextFormField, label);
  await tester.ensureVisible(field);
  await tester.enterText(field, nilai);
}

Future<void> _pilihPetakDanTanaman(WidgetTester tester) async {
  final petak = find.byType(RadioListTile<String>).first;
  await tester.ensureVisible(petak);
  await tester.tap(petak);

  final tanaman = find.byType(DropdownButtonFormField<String>);
  await tester.ensureVisible(tanaman);
  await tester.tap(tanaman);
  await tester.pumpAndSettle();
  await tester.tap(find.text('Padi').last);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('validasi angka dan batas kelembaban ditampilkan', (
    WidgetTester tester,
  ) async {
    final model = PrediksiModel();
    await _pumpHalamanInput(tester, model);
    await _pilihPetakDanTanaman(tester);

    await _isiField(tester, 'Prediksi Suhu Udara (°C)', 'hangat');
    await _isiField(tester, 'Prediksi Kelembaban Udara (%)', 'abc');
    await _isiField(tester, 'Prediksi Kelembaban Tanah (%)', '101');

    final simpan = find.text('Simpan dan Lihat Hasil');
    await tester.ensureVisible(simpan);
    await tester.tap(simpan);
    await tester.pumpAndSettle();

    expect(find.text('Masukkan angka yang valid'), findsNWidgets(2));
    expect(
      find.text('Nilai kelembaban harus antara 0 dan 100'),
      findsOneWidget,
    );
    expect(find.text('Bagian ini wajib diisi'), findsOneWidget);
    expect(model.daftar, isEmpty);
    await tester.pumpWidget(const SizedBox.shrink());
    model.dispose();
  });

  testWidgets(
    'data hanya disimpan setelah konfirmasi dan hasil diklasifikasi',
    (WidgetTester tester) async {
      final model = PrediksiModel();
      await _pumpHalamanInput(tester, model);
      await _pilihPetakDanTanaman(tester);

      await _isiField(tester, 'Prediksi Suhu Udara (°C)', '27.5');
      await _isiField(tester, 'Prediksi Kelembaban Udara (%)', '39');
      await _isiField(tester, 'Prediksi Kelembaban Tanah (%)', '70');
      await _isiField(tester, 'Nama Petugas', 'Ayu');

      final simpan = find.text('Simpan dan Lihat Hasil');
      await tester.ensureVisible(simpan);
      await tester.tap(simpan);
      await tester.pumpAndSettle();

      expect(find.text('Konfirmasi Data Prediksi'), findsOneWidget);
      expect(model.daftar, isEmpty);
      await tester.tap(find.text('Periksa Kembali'));
      await tester.pumpAndSettle();
      expect(model.daftar, isEmpty);

      await tester.ensureVisible(simpan);
      await tester.tap(simpan);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Ya, Simpan'));
      await tester.pumpAndSettle();

      expect(model.daftar, hasLength(1));
      expect(find.text('Status Kelembaban Udara'), findsOneWidget);
      expect(find.text('Kering'), findsOneWidget);
      expect(find.text('Status Kelembaban Tanah'), findsOneWidget);
      expect(find.text('Optimal'), findsOneWidget);
      expect(find.textContaining('pertimbangkan penyiraman'), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
      model.dispose();
    },
  );
}
