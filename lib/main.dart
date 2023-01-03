import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models/place.dart';
import './providers/great_place.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value:  GreatPlaces(),
      child: MaterialApp(
        title: 'Great Placees',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
      ),
    );
  }
}
