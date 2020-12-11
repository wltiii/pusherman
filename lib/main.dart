import 'package:flutter/material.dart';

import 'features/schedule/presentation/pages/dependent_pill_boxes_page.dart';
import 'injection_container.dart' as di;


void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pusherman',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DependentPillBoxesPage(),
    );
  }
}