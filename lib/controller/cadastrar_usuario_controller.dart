import 'package:flutter/material.dart';
import 'package:flutter_application/repositories/usuario_repository.dart';

class CadastrarUsuarioController {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  final users = UsuarioRepository.tabelaUser;

  String? validateNome(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo de nome obrigatório';
    }
    final RegExp nomeRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nomeRegExp.hasMatch(value)) {
      return 'Apenas letras e espaços';
    }
    return null;
  }

  String? validateEmail(String? value) {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );
    if (value == null || value.isEmpty) {
      return 'Campo de e-mail obrigatório';
    }
    if (!emailRegExp.hasMatch(value)) {
      return 'E-mail inválido';
    }
    for (var usuario in users) {
      if (usuario.email == value) {
        return 'E-mail já cadastrado';
      }
    }
    return null;
  }

  String? validateSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo de senha obrigatório';
    } else if (value.length < 5) {
      return 'A senha deve ter pelo menos 5 caracteres';
    }
    return null;
  }

  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
  }
}
