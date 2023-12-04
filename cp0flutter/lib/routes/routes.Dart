import 'package:flutter/material.dart';
import 'package:cp0flutter/frontend/projects/feed.dart';
import 'package:cp0flutter/frontend/User/visualizar.dart';
import 'package:cp0flutter/frontend/projects/Mprojects.dart';

class Routes {
  static const String initial = '/';
  static const String profile = '/profile';
  static const String myProjects = '/myProjects';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(builder: (_) => AllProjectsPage());
      case profile:
        return MaterialPageRoute(builder: (_) => UserProfileInfoPage());
      case myProjects:
        return MaterialPageRoute(builder: (_) => MyProjectsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Rota desconhecida: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
