import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'frontend/projects/feed.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CP-0',
      theme: ThemeData(
        primaryColor: const Color(0xFF120F42), // Primary color
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple, // Secondary color
        ),
        hintColor: const Color(0x0ff1d19b), // Accent color
        scaffoldBackgroundColor: const Color(0xFF3C34E0), // Background color
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF22294), // App bar background color
        ),
        useMaterial3: true,
      ),
      initialRoute: Routes.initial,
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
      home: const AllProjectsPage(),
    );
  }
}
