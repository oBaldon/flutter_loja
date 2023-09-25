import 'package:flutter/material.dart';
import 'package:flutter_application/pages/carrinho_page.dart';
import 'package:flutter_application/pages/produto_detalhes_page.dart';
import 'package:flutter_application/repositories/produto_repository.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application/models/produto.dart';

class StorePage extends StatefulWidget {
  StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final tabela = ProdutoRepository.tabela;

  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  List<Produto> selecionados = [];

  appBarDinamica() {
    if (selecionados.isEmpty) {
      return AppBar(
        title: Text('Produtos'),
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            setState(() {
              selecionados = [];
            });
          },
        ),
        title: Text('${selecionados.length} selecionados'),
      );
    }
  }

  mostrarDetalhes(Produto produto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProdutoDetalhesPage(produto: produto),
      ),
    );
  }

  setStateProdutos(int produto) {
    setState(() {
      (selecionados.contains(tabela[produto]))
          ? selecionados.remove(tabela[produto])
          : selecionados.add(tabela[produto]);
    });
  }

  checkoutCarrinho(List<Produto> selecionados) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CarrinhoPage(carrinho: selecionados),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int produto) {
          return ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            leading: (selecionados.contains(tabela[produto]))
                ? CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
                    child: Image.asset(tabela[produto].icone),
                    width: 40,
                  ),
            title: Text(
              tabela[produto].nome,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              real.format(tabela[produto].preco),
            ),
            selected: selecionados.contains(tabela[produto]),
            selectedTileColor: Colors.blueGrey[50],
            onTap: () {
              if (selecionados.isNotEmpty) {
                setStateProdutos(produto);
              } else {
                mostrarDetalhes(tabela[produto]);
              }
            },
            onLongPress: () {
              if (selecionados.isEmpty) {
                setStateProdutos(produto);
              }
            },
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, __) => Divider(),
        itemCount: tabela.length,
      ),
      floatingActionButton: selecionados.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                checkoutCarrinho(selecionados);
              },
              label: Icon(Icons.add_shopping_cart),
            )
          : null,
    );
  }
}
