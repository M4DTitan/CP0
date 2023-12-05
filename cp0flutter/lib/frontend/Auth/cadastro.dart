import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User? user = userCredential.user;
      if (user != null) {
        // Registro bem-sucedido, você pode redirecionar para a próxima tela ou fazer outras ações.
        print('Registro bem-sucedido: ${user.uid}');

        // Agora, adicione um documento ao Firestore com informações do usuário.
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user.uid)
            .set({
          'nome':
              'Nome do usuário', // Substitua 'Nome do usuário' pelo nome inserido pelo usuário no formulário.
          'email': _emailController.text,
          // Adicione mais campos conforme necessário.
        });

        print('Documento adicionado ao Firestore');
      }
    } catch (e) {
      print('Erro durante o registro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Senha',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Registrar'),
            ),
            Container(
              width: 1440,
              height: 84,
              clipBehavior: Clip.antiAlias,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFFEAEAEA),
                  ),
                ),
              ),
              child: Stack(
                children: [
                  const Positioned(
                    left: 90,
                    top: 36,
                    child: Text(
                      'Project-CP0',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.80,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 1199,
                    top: 23,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 118,
                            height: 38,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF23A8F4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 13,
                                  height: 13,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Stack(children: []),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Registrar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w900,
                                    height: 0,
                                    letterSpacing: 0.24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 131,
                          top: 0,
                          child: Container(
                            width: 75,
                            height: 38,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFEAEAEA),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Entrar',
                                  style: TextStyle(
                                    color: Color(0xFF1682FD),
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w900,
                                    height: 0,
                                    letterSpacing: 0.24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 580,
              height: 700,
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 193),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Faça parte da comunidade CP0.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w900,
                      height: 0,
                      letterSpacing: 1.20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 42,
                          padding: const EdgeInsets.only(
                            top: 8,
                            left: 15,
                            right: 139,
                            bottom: 25,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFEAEAEA)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 226,
                                child: Text(
                                  'Username',
                                  style: TextStyle(
                                    color: Color(0xFF808080),
                                    fontSize: 8,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    height: 0,
                                    letterSpacing: 0.16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: 42,
                          padding: const EdgeInsets.only(
                            top: 8,
                            left: 15,
                            right: 139,
                            bottom: 25,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFEAEAEA)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 226,
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                    color: Color(0xFF808080),
                                    fontSize: 8,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    height: 0,
                                    letterSpacing: 0.16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: 380,
                          padding: const EdgeInsets.only(
                            top: 14,
                            left: 15,
                            right: 306,
                            bottom: 13,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFEAEAEA)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Password',
                                style: TextStyle(
                                  color: Color(0xFF808080),
                                  fontSize: 13,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w300,
                                  height: 0,
                                  letterSpacing: 0.26,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: 380,
                          padding: const EdgeInsets.only(
                            top: 14,
                            left: 15,
                            right: 268,
                            bottom: 13,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFEAEAEA)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Repetit pasword',
                                style: TextStyle(
                                  color: Color(0xFF808080),
                                  fontSize: 13,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w300,
                                  height: 0,
                                  letterSpacing: 0.26,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Opacity(
                          opacity: 0.50,
                          child: Container(
                            width: 380,
                            padding: const EdgeInsets.only(top: 12, bottom: 11),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF2350F4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Cadastrar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w900,
                                    height: 0,
                                    letterSpacing: 0.26,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 931,
              height: 732,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: const Stack(
                children: [
                  Positioned(
                    left: 81.46,
                    top: 81.59,
                    child: SizedBox(
                      width: 759.65,
                      height: 477.92,
                      child: Stack(children: []),
                    ),
                  ),
                  Positioned(
                    left: 139.60,
                    top: 126.68,
                    child: SizedBox(
                      width: 269.57,
                      height: 495.94,
                      child: Stack(children: []),
                    ),
                  ),
                  Positioned(
                    left: 282.01,
                    top: 228.85,
                    child: SizedBox(
                      width: 488.08,
                      height: 403.67,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 55.19,
                            top: -0,
                            child: Opacity(
                              opacity: 0.10,
                              child: SizedBox(
                                width: 432.89,
                                height: 403.67,
                                child: Stack(children: []),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 689.56,
                    top: 122.66,
                    child: SizedBox(
                      width: 110.15,
                      height: 352.85,
                      child: Stack(children: []),
                    ),
                  ),
                  Positioned(
                    left: 322,
                    top: 98.88,
                    child: SizedBox(
                      width: 68.35,
                      height: 73.62,
                      child: Stack(children: []),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
