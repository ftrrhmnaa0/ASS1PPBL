import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../model/prediksi_model.dart';

class StatistikPage extends StatelessWidget {
 const StatistikPage({super.key});

 @override
 Widget build(BuildContext context) {
 final model = context.watch<PrediksiModel>();
 final jumlahPetak1 = model.jumlahSesi('Petak 1');
 final jumlahPetak2 = model.jumlahSesi('Petak 2');
 return Scaffold(
 appBar: AppBar(title: const Text('Statistik Prediksi')),
 body: Padding(
   padding: const EdgeInsets.all(16),
   child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Text(
         'Jumlah prediksi: ${model.daftar.length}',
         style: Theme.of(context).textTheme.titleLarge,
       ),
       const SizedBox(height: 24),
       if (model.daftar.isEmpty)
         const Expanded(
           child: Center(
             child: Text(
               'Belum ada data prediksi. Tambahkan data melalui menu Prediksi.',
               textAlign: TextAlign.center,
             ),
           ),
         )
       else
         Expanded(
           child: BarChart(
             BarChartData(
               maxY: (jumlahPetak1 > jumlahPetak2
                       ? jumlahPetak1
                       : jumlahPetak2)
                   .toDouble() +
                   1,
               barGroups: [
                 BarChartGroupData(
                   x: 0,
                   barRods: [BarChartRodData(toY: jumlahPetak1.toDouble())],
                 ),
                 BarChartGroupData(
                   x: 1,
                   barRods: [BarChartRodData(toY: jumlahPetak2.toDouble())],
                 ),
               ],
             ),
           ),
         ),
       const SizedBox(height: 16),
       const Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           Text('Petak 1', style: TextStyle(fontWeight: FontWeight.w600)),
           Text('Petak 2', style: TextStyle(fontWeight: FontWeight.w600)),
         ],
       ),
       const SizedBox(height: 8),
       Text('Petak 1: $jumlahPetak1  •  Petak 2: $jumlahPetak2'),
     ],
   ),
 ),
 );
 }
}
