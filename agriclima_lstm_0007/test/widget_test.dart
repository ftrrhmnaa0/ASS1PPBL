import 'package:flutter_test/flutter_test.dart';

import 'package:agriclima_lstm_0007/main.dart';

void main() {
  testWidgets('halaman dapat dibuka melalui navigasi utama', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AplikasiNavigasi());

    expect(find.text('Selamat Datang di AgriClima LSTM'), findsOneWidget);

    await tester.tap(find.text('Prediksi').last);
    await tester.pumpAndSettle();
    expect(find.text('Input Prediksi'), findsOneWidget);

    await tester.tap(find.text('Statistik').last);
    await tester.pumpAndSettle();
    expect(find.text('Statistik Prediksi'), findsOneWidget);

    await tester.tap(find.text('Tentang').last);
    await tester.pumpAndSettle();
    expect(find.text('AgriClima LSTM'), findsOneWidget);
  });
}
