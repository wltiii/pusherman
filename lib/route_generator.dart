import 'package:flutter/material.dart';

import 'features/schedule/presentation/pages/dependent_pill_boxes_page.dart';
import 'features/schedule/presentation/pages/initial_setup_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => DependentPillBoxesPage());
      case '/setup':
        return MaterialPageRoute( builder: (_) => InitialSetupPage() );
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}