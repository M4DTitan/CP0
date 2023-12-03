import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _fieldOfStudyController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userSnapshot = await _firestore.collection('usuarios').doc(user.uid).get();
        if (userSnapshot.exists) {
          Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
          _institutionController.text = userData['institution'] ?? '';
          _fieldOfStudyController.text = userData['fieldOfStudy'] ?? '';
          _cityController.text = userData['city'] ?? '';
          _ageController.text = userData['age'] ?? '';
          _bioController.text = userData['bio'] ?? '';
        }
      }
    } catch (e) {
      print('Erro ao buscar informações do perfil: $e');
    }
  }

  Future<void> _updateUserProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('usuarios').doc(user.uid).set({
          'institution': _institutionController.text,
          'fieldOfStudy': _fieldOfStudyController.text,
          'city': _cityController.text,
          'age': _ageController.text,
          'bio': _bioController.text,
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print('Erro ao atualizar informações do perfil: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _institutionController,
              decoration: InputDecoration(labelText: 'Instituição'),
            ),
            TextFormField(
              controller: _fieldOfStudyController,
              decoration: InputDecoration(labelText: 'Área de Formação'),
            ),
            TextFormField(
              controller: _cityController,
              decoration: InputDecoration(labelText: 'Cidade'),
            ),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Idade'),
            ),
            TextFormField(
              controller: _bioController,
              decoration: InputDecoration(labelText: 'Bio (máx. 250 caracteres)'),
              maxLines: 4,
            ),
            ElevatedButton(
              onPressed: _updateUserProfile,
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
