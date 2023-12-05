// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cp0flutter/routes/routes.dart';

class AllProjectsPage extends StatefulWidget {
  const AllProjectsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AllProjectsPageState createState() => _AllProjectsPageState();
}

class _AllProjectsPageState extends State<AllProjectsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunidade'),
        backgroundColor: const Color(0xFF120F42), // #120F42
        actions: [
          _buildIconButton(Icons.home, Routes.initial),
          _buildIconButton(Icons.folder, Routes.myProjects),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          _buildIconButton(Icons.person, Routes.profile),
        ],
      ),
      body: _buildProjectsList(),
      bottomNavigationBar: _buildFooter(),
    );
  }

  IconButton _buildIconButton(IconData icon, String route) {
    return IconButton(
      icon: Icon(icon),
      color: const Color(0xFF1D19B), // #1D19B
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _buildProjectsList() {
    // Dummy list of projects (replace this with your actual data from Firestore)
    final List<Map<String, dynamic>> dummyProjects = [
      {'title': 'Projeto 1', 'description': 'Descrição do Projeto 1'},
      {'title': 'Projeto 2', 'description': 'Descrição do Projeto 2'},
      {'title': 'Projeto 3', 'description': 'Descrição do Projeto 3'},
      {'title': 'Projeto 4', 'description': 'Descrição do Projeto 4'},
      {'title': 'Projeto 5', 'description': 'Descrição do Projeto 5'},
      {'title': 'Projeto 6', 'description': 'Descrição do Projeto 6'},
      // Add more projects as needed
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: dummyProjects.length,
      itemBuilder: (context, index) {
        final project = dummyProjects[index];
        return Card(
          elevation: 3.0,
          color: const Color(0xFF3C34E0), // #3C34E0
          child: ListTile(
            title: Text(
              project['title'] ?? 'Título não disponível',
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              project['description'] ?? 'Descrição não disponível',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildFooter() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    color: const Color(0xFF22294), // #22294
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '© 2023 Heldério Wafunga. Todos os direitos reservados.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
      ],
    ),
  );
}
