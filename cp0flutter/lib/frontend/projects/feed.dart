import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllProjectsPage extends StatefulWidget {
  const AllProjectsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AllProjectsPageState createState() => _AllProjectsPageState();
}

class _AllProjectsPageState extends State<AllProjectsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunidade'),
      ),
      body: FutureBuilder(
        future: _fetchAllProjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final List<DocumentSnapshot> projects =
                snapshot.data as List<DocumentSnapshot>;
            return ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(project['title'] ?? 'Título não disponível'),
                  subtitle: Text(
                      project['description'] ?? 'Descrição não disponível'),
                  // Outros campos do projeto podem ser exibidos aqui
                );
              },
            );
          } else {
            return const Text('Nenhum projeto encontrado.');
          }
        },
      ),
    );
  }

  Future<List<DocumentSnapshot>> _fetchAllProjects() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        QuerySnapshot querySnapshot = await _firestore
            .collection('projects')
            .where('authorId', isNotEqualTo: user.uid)
            .get();

        return querySnapshot.docs;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Erro ao buscar todos os projetos: $e');
    }
    return [];
  }
}
