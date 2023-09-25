import 'package:flutter/material.dart';
import 'package:flutter_application/models/produto.dart';
import 'package:intl/intl.dart';

class CarrinhoPage extends StatefulWidget {
  final List<Produto> carrinho;

  CarrinhoPage({Key? key, required this.carrinho}) : super(key: key);

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int produto) {
          return ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            leading: SizedBox(
              child: Image.asset(widget.carrinho[produto].icone),
            ),
            title: Text(
              widget.carrinho[produto].nome,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              real.format(widget.carrinho[produto].preco),
            ),
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, __) => Divider(),
        itemCount: widget.carrinho.length,
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final snackBar = SnackBar(
              content: Text('COMPROU!'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          label: Text('Comprar')),
    );
  }
}
