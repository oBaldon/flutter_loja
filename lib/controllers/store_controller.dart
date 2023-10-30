import 'package:flutter/material.dart';
import 'package:flutter_application/pages/carrinho_page.dart';
import 'package:flutter_application/pages/produto_detalhes_page.dart';
import 'package:flutter_application/repositories/carrinho_repository.dart';
import 'package:flutter_application/repositories/produto_repository.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application/models/produto.dart';
import 'package:provider/provider.dart';

class StoreController {
  final tabela = ProdutoRepository.tabela;
  late CarrinhoRepository carrinho;
  final List<Produto> selecionados = [];

  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

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

  void checkoutCarrinho(BuildContext context) {
    carrinho = Provider.of<CarrinhoRepository>(context, listen: false);
    carrinho.saveAll(selecionados);
    selecionados.clear();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CarrinhoPage(),
      ),
    );
  }
}
