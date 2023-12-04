//import 'package:cp0flutter/frontend/Auth/cadastro.dart';
//import 'package:cp0flutter/frontend/Auth/login.dart';
import 'package:flutter/material.dart';
//import 'package:cp0flutter/frontend/Auth/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'frontend/projects/feed.dart';
import 'routes/routes.dart';
//import 'frontend/projects/addproject.dart';
//import 'frontend/User/update.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CP-0',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routes.initial,
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
      home: const AllProjectsPage(),
    );
  }
}
