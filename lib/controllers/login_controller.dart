import 'package:flutter/material.dart';
import 'package:flutter_application/repositories/usuario_repository.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  final users = UsuarioRepository.tabelaUser;

  String? validateEmail(String? value) {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );

    if (value == null || value.isEmpty) {
      return 'Informe um e-mail';
    }
    if (!emailRegExp.hasMatch(value)) {
      return 'E-mail inválido';
    }
    for (var usuario in users) {
      if (usuario.email != value) {
        return 'E-mail não cadastrado';
      }
    }
    return null;
  }

  String? validateSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe uma senha';
    }
    for (var usuario in users) {
      if (usuario.senha != value) {
        return 'Senha incorreta';
      }
    }
    return null;
  }

  void dispose() {
    emailController.dispose();
    senhaController.dispose();
  }
}
