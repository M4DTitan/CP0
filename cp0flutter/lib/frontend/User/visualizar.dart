import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileInfoPage extends StatefulWidget {
  const UserProfileInfoPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserProfileInfoPageState createState() => _UserProfileInfoPageState();
}

class _UserProfileInfoPageState extends State<UserProfileInfoPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int projectCount = 0;
  int followersCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserProfileInfo();
  }

  Future<void> _fetchUserProfileInfo() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Buscar informações do perfil do usuário
        DocumentSnapshot userSnapshot =
            await _firestore.collection('usuarios').doc(user.uid).get();
        if (userSnapshot.exists) {
          // Exibir informações do perfil do usuário
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          setState(() {
            projectCount = userData['projectCount'] ?? 0;
            followersCount = userData['followersCount'] ?? 0;
          });
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print('Erro ao buscar informações do perfil: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações de Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Nome de Usuário'), // Substitua por nome de usuário real
            const Text('E-mail do Usuário'), // Substitua por e-mail real
            const Text('Instituição'), // Substitua por instituição real
            const Text(
                'Área de Formação'), // Substitua por área de formação real
            const Text('Cidade'), // Substitua por cidade real
            const Text('Idade'), // Substitua por idade real
            const Text('Bio (máx. 250 caracteres)'), // Substitua por bio real
            const SizedBox(height: 16),
            Text('Projetos Publicados: $projectCount'),
            Text('Seguidores: $followersCount'),
          ],
        ),
      ),
    );
  }
}
