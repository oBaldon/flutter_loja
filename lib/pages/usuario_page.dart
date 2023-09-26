import 'package:flutter/material.dart';
import 'package:flutter_application/models/usuario.dart';

class UsuarioPage extends StatefulWidget {
  final Usuario usuario;

  UsuarioPage({Key? key, required this.usuario}) : super(key: key);

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 75,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(widget.usuario.icone),
              ),
              SizedBox(height: 20),
              Text(
                'Nome: ${widget.usuario.nome}',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  letterSpacing: -1,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Email: ${widget.usuario.email}',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.normal,
                  fontSize: 26,
                  letterSpacing: -1,
                ),
              ),
            ],
          )),
    );
  }
}
