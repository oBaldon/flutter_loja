import 'package:flutter/material.dart';
import 'package:flutter_application/pages/carrinho_page.dart';
import 'package:flutter_application/pages/produto_detalhes_page.dart';
import 'package:flutter_application/repositories/produto_repository.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application/models/produto.dart';

class StoreController {
  final tabela = ProdutoRepository.tabela;

  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  List<Produto> selecionados = [];

  late Function() onSelectionChanged;
  void setStateProdutos(int produto) {
    if (selecionados.contains(tabela[produto])) {
      selecionados.remove(tabela[produto]);
    } else {
      selecionados.add(tabela[produto]);
    }
    onSelectionChanged();
  }

  void mostrarDetalhes(BuildContext context, Produto produto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProdutoDetalhesPage(produto: produto),
      ),
    );
  }

  void checkoutCarrinho(BuildContext context, List<Produto> selecionados) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CarrinhoPage(carrinho: selecionados),
      ),
    );
  }
}
