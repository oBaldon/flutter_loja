import 'package:flutter/material.dart';
import 'package:flutter_application/models/produto.dart';
import 'package:intl/intl.dart';

class ProdutoDetalhesPage extends StatefulWidget {
  final Produto produto;

  ProdutoDetalhesPage({Key? key, required this.produto}) : super(key: key);

  @override
  State<ProdutoDetalhesPage> createState() => _ProdutoDetalhesPageState();
}

class _ProdutoDetalhesPageState extends State<ProdutoDetalhesPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.produto.nome),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                child: Image.asset(widget.produto.icone),
                width: 150,
                height: 150,
              ),
            ),
            Container(height: 20),
            Text(
              'Nome: ${widget.produto.nome}',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 26,
                letterSpacing: -1,
              ),
            ),
            Container(height: 20),
            Text(
              'Preço: ${real.format(widget.produto.preco)}',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 26,
                letterSpacing: -1,
              ),
            ),
            Container(height: 10),
            Text(
              'Tipo: ${widget.produto.tipo}',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal,
                fontSize: 22,
                letterSpacing: -1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
