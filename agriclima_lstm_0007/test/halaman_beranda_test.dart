import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agriclima_lstm_0007/pages/halaman_beranda.dart';

void main() {
  testWidgets('kartu informasi berada di atas tombol Tentang Aplikasi', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: HalamanBeranda(onNavigate: (_) {})),
    );

    final card = find.byKey(const ValueKey('beranda-info-card'));
    final aboutButton = find.text('Tentang Aplikasi');

    expect(card, findsOneWidget);
    expect(aboutButton, findsOneWidget);
    expect(tester.getTopLeft(card).dy, lessThan(300));
    expect(
      tester.getTopLeft(card).dy,
      lessThan(tester.getTopLeft(aboutButton).dy),
    );
  });
}
