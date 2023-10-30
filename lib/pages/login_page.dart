import 'package:flutter/material.dart';
import 'package:flutter_application/models/usuario.dart';
import 'package:flutter_application/pages/cadastrar_usuario_page.dart';
import 'package:flutter_application/pages/usuario_page.dart';
import 'package:flutter_application/controllers/login_controller.dart';
import 'package:flutter_application/repositories/usuario_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? emailValido, senhaValida;

  final users = UsuarioRepository.tabelaUser;

  final _form = GlobalKey<FormState>();
  final LoginController _loginController = LoginController();

  logar() {
    Usuario autenticado = Usuario(
      icone: '',
      nome: '',
      email: '',
      senha: '',
    );

    if (_form.currentState!.validate()) {
      for (var usuario in users) {
        if (usuario.email == _loginController.emailController.text &&
            usuario.senha == _loginController.senhaController.text) {
          autenticado = usuario;
          break;
        }
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UsuarioPage(usuario: autenticado),
        ),
      );
    }
  }

  cadastrarNovoUsuario() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CadastrarUsuarioPage(),
      ),
    );
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
                      return _loginController.validateEmail(value);
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: cadastrarNovoUsuario,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_add),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Cadastrar-se',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
