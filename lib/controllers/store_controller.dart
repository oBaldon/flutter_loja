import 'package:flutter/material.dart';
import 'package:flutter_application/pages/carrinho_page.dart';
import 'package:flutter_application/pages/produto_detalhes_page.dart';
import 'package:flutter_application/repositories/carrinho_repository.dart';
import 'package:flutter_application/repositories/produto_api.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application/models/produto.dart';
import 'package:provider/provider.dart';

class StoreController {
  final ProdutoAPI produtoAPI = ProdutoAPI();

  late CarrinhoRepository carrinho;
  late List<Produto> tabela = [];
  final List<Produto> selecionados = [];

  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  late Function() onSelectionChanged;

  Future<void> getProdutos() async {
    tabela = await produtoAPI.getProdutos();
  }

  void setStateProdutos(int produto) async {
    Produto produtoSelecionado = tabela[produto];

    if (selecionados.contains(produtoSelecionado)) {
      selecionados.remove(produtoSelecionado);
    } else {
      selecionados.add(produtoSelecionado);
    }
    tabela = await produtoAPI.getProdutos();
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CarrinhoPage(),
      ),
    );
  }
}
