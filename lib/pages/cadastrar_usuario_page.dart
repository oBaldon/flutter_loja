import 'package:flutter/material.dart';
import 'package:flutter_application/controller/cadastrar_usuario_controller.dart';
import 'package:flutter_application/models/usuario.dart';
import 'package:flutter_application/repositories/usuario_repository.dart';

class CadastrarUsuarioPage extends StatefulWidget {
  const CadastrarUsuarioPage({super.key});

  @override
  _CadastrarUsuarioPageState createState() => _CadastrarUsuarioPageState();
}

class _CadastrarUsuarioPageState extends State<CadastrarUsuarioPage> {
  String? emailValido, senhaValida, nomeValido;

  final _form = GlobalKey<FormState>();
  final CadastrarUsuarioController _cadastrarUserController =
      CadastrarUsuarioController();

  cadastrarUsuario() {
    if (_form.currentState!.validate()) {
      Usuario novoUsuario = Usuario(
        icone: 'images/person.png',
        nome: _cadastrarUserController.nomeController.text,
        email: _cadastrarUserController.emailController.text,
        senha: _cadastrarUserController.senhaController.text,
      );

      UsuarioRepository.tabelaUser.add(novoUsuario);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuário cadastrado com sucesso!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrar como novo usuario'),
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
                    'Registrar-se',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            Form(
              key: _form,
              child: Column(
                children: [
                  // Campo nome
                  TextFormField(
                    controller: _cadastrarUserController.nomeController,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome',
                      prefixIcon: Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      return _cadastrarUserController.validateNome(value);
                    },
                  ),
                  SizedBox(height: 16),
                  // Campo email
                  TextFormField(
                    controller: _cadastrarUserController.emailController,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                      prefixIcon: Icon(Icons.email_sharp),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      return _cadastrarUserController.validateEmail(value);
                    },
                  ),
                  SizedBox(height: 16),
                  //Campo senha
                  TextFormField(
                    controller: _cadastrarUserController.senhaController,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value) {
                      return _cadastrarUserController.validateSenha(value);
                    },
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: cadastrarUsuario,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Enviar',
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
