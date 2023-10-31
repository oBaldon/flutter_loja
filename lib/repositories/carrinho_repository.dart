import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/databases/db_firestore.dart';
import 'package:flutter_application/models/produto.dart';
import 'package:flutter_application/repositories/produto_repository.dart';
import 'package:flutter_application/services/auth_service.dart';

class CarrinhoRepository extends ChangeNotifier {
  List<Produto> _lista = [];
  late FirebaseFirestore db;
  late AuthService auth;

  CarrinhoRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readCarrinho();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readCarrinho() async {
    if (auth.usuario != null && _lista.isEmpty) {
      final snapshot =
          await db.collection('usuarios/${auth.usuario!.uid}/carrinho').get();

      snapshot.docs.forEach((doc) {
        if (doc.data().containsKey('nome')) {
          Produto produto = ProdutoRepository.tabela
              .firstWhere((produto) => produto.nome == doc.get('nome'));
          _lista.add(produto);
          notifyListeners();
        } else {
          return null;
        }
      });
    }
  }

  UnmodifiableListView<Produto> get lista => UnmodifiableListView(_lista);

  saveAll(List<Produto> produtos) {
    produtos.forEach((produto) async {
      if (!_lista.contains(produto)) {
        _lista.add(produto);
        await db
            .collection('usuarios/${auth.usuario!.uid}/carrinho')
            .doc(produto.nome)
            .set({
          'produto': produto.nome,
          'tipo': produto.tipo,
          'preco': produto.preco,
        });
      }
    });
    notifyListeners();
  }

  removeAll(List<Produto> produtos) {
    _lista = [];
    notifyListeners();
  }

  add(Produto produto) {
    _lista.add(produto);
    notifyListeners();
  }

  remove(Produto produto) async {
    await db
        .collection('usuarios/${auth.usuario!.uid}/carrinho')
        .doc(produto.nome)
        .delete();
    _lista.remove(produto);
    notifyListeners();
  }
}
