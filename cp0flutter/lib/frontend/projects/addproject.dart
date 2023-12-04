import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class UploadProjectPage extends StatefulWidget {
  const UploadProjectPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UploadProjectPageState createState() => _UploadProjectPageState();
}

class _UploadProjectPageState extends State<UploadProjectPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Reference storageRef = _storage.ref().child('uploads/');
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  String _selectedCategory =
      "Categoria 1"; // Você pode preencher com categorias reais

  String _error = "";

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Use o plugin file_picker para selecionar um arquivo
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile file = result.files.first;

        // Faça o upload do arquivo para o Firebase Storage
        UploadTask task = storageRef.child(file.name).putData(file.bytes!);

        // Aguarde o término do upload
        await task.whenComplete(() {
          print('Upload bem-sucedido');
        });
      }
    }
  }

  Future<void> _uploadProject() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Obtenha os valores dos campos do formulário
        String title = _titleController.text;
        String description = _descriptionController.text;
        String category = _selectedCategory;

        // Faça o upload dos dados do projeto no Firestore
        await _firestore.collection('projects').add({
          'title': title,
          'description': description,
          'category': category,
          'authorId': user.uid,
          // Outros campos, como ID e arquivos relacionados, podem ser adicionados conforme necessário.
        });

        // Limpe os campos do formulário
        _titleController.clear();
        _descriptionController.clear();
        _categoryController.clear();

        // Redirecione ou exiba uma mensagem de sucesso, se necessário
        // ignore: avoid_print
        print('Projeto enviado com sucesso!');
      }
    } catch (e) {
      setState(() {
        _error = 'Erro durante o envio do projeto: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Envie um Projeto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            DropdownButtonFormField(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: ["Categoria 1", "Categoria 2", "Categoria 3"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Categoria'),
            ),
            ElevatedButton(
              onPressed: () {
                Future<String?> selectFile() async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    PlatformFile file = result.files.first;
                    return file
                        .path; // Retorna o caminho do arquivo selecionado.
                  } else {
                    return null; // O usuário cancelou a seleção do arquivo.
                  }
                }
              },
              child: const Text('Selecionar Arquivo'),
            ),
            ElevatedButton(
              onPressed: _uploadProject,
              child: const Text('Enviar Projeto'),
            ),
            if (_error.isNotEmpty) Text(_error),
          ],
        ),
      ),
    );
  }
}
