import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'cubit/tema_cubit.dart';
import 'model/prediksi_model.dart';
import 'navigation/app_routes.dart';
import 'navigation/kerangka_navigasi.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PrediksiModel()),
      ],
      child: BlocProvider(
        create: (_) => TemaCubit(),
        child: const AplikasiNavigasi(),
      ),
    ),
  );
}

class AplikasiNavigasi extends StatelessWidget {
  const AplikasiNavigasi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemaCubit, ThemeMode>(
      builder: (context, mode) => MaterialApp(
        title: 'AgriClima',
        debugShowCheckedModeBanner: false,
        themeMode: mode,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const KerangkaNavigasi(),
        routes: AppRoutes.daftarRoute(),
        onGenerateRoute: AppRoutes.bentukRoute,
        onUnknownRoute: AppRoutes.routeTidakDikenal,
      ),
    );
  }
}
