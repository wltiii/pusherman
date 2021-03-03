import 'package:flutter/material.dart';
import 'package:pusherman/route_generator.dart';

// import 'features/schedule/presentation/pages/dependent_pill_boxes_page.dart';
import 'service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pusherman - I'm Your Doctor",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: isSetupComplete() ? '/' : '/setup',
      // home: DependentPillBoxesPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  bool isSetupComplete() {
    return true;
  }
}