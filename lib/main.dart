import 'package:average_point_counter/screens/mean.dart';
import 'package:average_point_counter/screens/weighted.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Расчёт среднего балла',
    initialRoute: '/mean_average',
    theme: ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(213, 39, 40, 1),
              width: 1,
            )
        ),
      )
    ),
    routes: {
      '/mean_average': (context) => const MeanPointPage(),
      '/weighted_average': (context) => const WeightedAveragePage()
    },
  ));
}
