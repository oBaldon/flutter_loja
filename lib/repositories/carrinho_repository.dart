import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_application/models/produto.dart';

class CarrinhoRepository extends ChangeNotifier {
  List<Produto> _lista = [];

  UnmodifiableListView<Produto> get lista => UnmodifiableListView(_lista);

  saveAll(List<Produto> produtos) {
    produtos.forEach((produto) {
      if (!_lista.contains(produto)) {
        _lista.add(produto);
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

  remove(Produto produto) {
    _lista.remove(produto);
    notifyListeners();
  }
}
