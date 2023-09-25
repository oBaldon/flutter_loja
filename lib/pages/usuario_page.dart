import 'package:flutter/material.dart';
import '../controller/login_controller.dart';
import '../repositories/usuario_repository.dart';

class UsuarioPage extends StatefulWidget {
  const UsuarioPage({super.key});

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  String? emailValido;

  final users = UsuarioRepository.tabelaUser;

  final _form = GlobalKey<FormState>();
  final LoginController _loginController = LoginController();

  logar() {
    if (_form.currentState!.validate()) {
      if (emailValido == 's') {
        print("logado");
      } else {
        print(emailValido);
      }
    }
  }

  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Perfil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(width: 10),
                  Text(
                    'Logar',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            Form(
              key: _form,
              child: Column(
                children: [
                  // Campo email
                  TextFormField(
                    controller: _loginController.emailController,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                      prefixIcon: Icon(Icons.email_sharp),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      emailValido = _loginController.validateEmail(value);
                      return emailValido;
                    },
                  ),
                  SizedBox(height: 16),
                  //Campo senha
                  TextFormField(
                    controller: _loginController.senhaController,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value) {
                      return _loginController.validateSenha(value);
                    },
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: logar,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Entrar',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
