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
        backgroundColor: const Color(0xFF120F42), // Deep Blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
                'Nome de Usuário', 'JohnDoe'), // Replace with real username
            _buildInfoRow('E-mail do Usuário',
                'john.doe@example.com'), // Replace with real email
            _buildInfoRow('Instituição',
                'Universidade XYZ'), // Replace with real institution
            _buildInfoRow('Área de Formação',
                'Ciência da Computação'), // Replace with real field of study
            _buildInfoRow('Cidade', 'Cidade ABC'), // Replace with real city
            _buildInfoRow('Idade', '25 anos'), // Replace with real age
            _buildInfoRow(
              'Bio (máx. 250 caracteres)',
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget velit euismod, rhoncus elit non, laoreet turpis.',
            ), // Replace with real bio

            const SizedBox(height: 20),

            Text('Projetos Publicados: $projectCount'),
            Text('Seguidores: $followersCount'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0x0ff1d19b), // Light Blue
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF332BBD), // Dark Blue
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
