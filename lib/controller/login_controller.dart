import 'package:flutter/material.dart';
import 'package:flutter_application/repositories/usuario_repository.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  final users = UsuarioRepository.tabelaUser;
  bool isLoggedIn = false;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe um e-mail';
    } else {
      bool emailValid = RegExp(r"/^[a-z0-9.]+@[a-z0-9]+\.[a-z]+\.([a-z]+)?$/i")
          .hasMatch(value);
      if (emailValid) {
        return "E-mail valido";
      }
    }

    return null;
  }

  String? validateSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe uma senha';
    }
    //mais validações de senha
    return null;
  }

  void dispose() {
    emailController.dispose();
    senhaController.dispose();
  }
}
