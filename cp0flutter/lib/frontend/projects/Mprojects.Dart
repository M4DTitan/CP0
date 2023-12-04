import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyProjectsPage extends StatefulWidget {
  @override
  _MyProjectsPageState createState() => _MyProjectsPageState();
}

class _MyProjectsPageState extends State<MyProjectsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus '),
      ),
      body: FutureBuilder(
        future: _fetchUserProjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final List<DocumentSnapshot> projects = snapshot.data as List<DocumentSnapshot>;
            return ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(project['title'] ?? 'Título não disponível'),
                  subtitle: Text(project['description'] ?? 'Descrição não disponível'),
                  // Outros campos do projeto podem ser exibidos aqui
                );
              },
            );
          } else {
            return Text('Nenhum projeto encontrado.');
          }
        },
      ),
    );
  }

  Future<List<DocumentSnapshot>> _fetchUserProjects() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        QuerySnapshot querySnapshot = await _firestore
            .collection('projects')
            .where('authorId', isEqualTo: user.uid)
            .get();

        return querySnapshot.docs;
      }
    } catch (e) {
      print('Erro ao buscar projetos do usuário: $e');
    }
    return [];
  }
}
