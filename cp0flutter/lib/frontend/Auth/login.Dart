import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importe o Firestore

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

 Future<void> _signIn() async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    User? user = userCredential.user;
    if (user != null) {
      // Login bem-sucedido, redirecione para a próxima tela.
      print('Login bem-sucedido: ${user.uid}');

      // Agora, você pode buscar os dados do usuário a partir do Firestore.
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('usuarios').doc(user.uid).get();

      if (userSnapshot.exists) {
        // Usuário encontrado, você pode acessar os dados.
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
        String nome = userData['nome'];
        String email = userData['email'];

        print('Nome do usuário: $nome');
        print('E-mail do usuário: $email');
      } else {
        // Usuário não encontrado na coleção "usuarios".
        print('Usuário não encontrado.');
      }
    }
  } catch (e) {
    print('Erro durante o login: $e');
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo de volta'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _signIn,
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: _signIn,
              child: Text('Cadastar'),
            ),
          ],
        ),
      ),
    );
  }
}
