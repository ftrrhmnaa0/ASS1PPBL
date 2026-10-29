import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Mengelola ThemeMode global menggunakan Cubit.
class TemaCubit extends Cubit<ThemeMode> {
  TemaCubit() : super(ThemeMode.light);

  void aturTemaGelap(bool aktif) {
    emit(aktif ? ThemeMode.dark : ThemeMode.light);
  }

  void toggle() {
    emit(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }
}
