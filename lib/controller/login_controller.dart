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
      for (var usuario in users) {
        if (usuario.email != value) {
          return 'E-mail não cadastrado';
        } else {
          return null;
        }
      }
    }
    return null;
  }

  String? validateSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe uma senha';
    } else {
      for (var usuario in users) {
        if (usuario.senha != value) {
          return 'Senha incorreta';
        } else {
          return null;
        }
      }
    }
    return null;
  }

  void dispose() {
    emailController.dispose();
    senhaController.dispose();
  }
}
