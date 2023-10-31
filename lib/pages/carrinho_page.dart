import 'package:flutter/material.dart';
import 'package:flutter_application/controllers/carrinho_controller.dart';
import 'package:flutter_application/repositories/carrinho_repository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CarrinhoPage extends StatefulWidget {
  CarrinhoPage({Key? key}) : super(key: key);

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  late CarrinhoRepository carrinho;
  final controller = CarrinhoController();

  @override
  Widget build(BuildContext context) {
    carrinho = Provider.of<CarrinhoRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: carrinho.lista.isEmpty
          ? Center(
              child: Text('Carrinho vazio!'),
            )
          : ListView.separated(
              itemBuilder: (BuildContext context, int produto) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  leading: Image.asset(carrinho.lista[produto].icone),
                  title: Text(
                    carrinho.lista[produto].nome,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        real.format(carrinho.lista[produto].preco),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          controller.atualizarCarrinho(
                              context, carrinho.lista[produto]);
                        },
                      ),
                    ],
                  ),
                );
              },
              padding: EdgeInsets.all(16),
              separatorBuilder: (_, __) => Divider(),
              itemCount: carrinho.lista.length,
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          carrinho.removeAll(carrinho.lista);
          final snackBar = SnackBar(
            content: Text('Todos os produtos foram removidos do carrinho'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        label: Text('Comprar'),
      ),
    );
  }
}
