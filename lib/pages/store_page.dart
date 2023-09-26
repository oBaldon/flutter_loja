import 'package:flutter/material.dart';
import 'package:flutter_application/controller/store_controller.dart';

class StorePage extends StatefulWidget {
  StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final controller = StoreController();

  @override
  void initState() {
    super.initState();
    controller.onSelectionChanged = () {
      setState(() {});
    };
  }

  AppBar appBarDinamica() {
    if (controller.selecionados.isEmpty) {
      return AppBar(
        title: Text('Produtos'),
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            setState(() {
              controller.selecionados = [];
            });
          },
        ),
        title: Text('${controller.selecionados.length} selecionados'),
      );
    }
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
            leading:
                (controller.selecionados.contains(controller.tabela[produto]))
                    ? CircleAvatar(
                        child: Icon(Icons.check),
                      )
                    : SizedBox(
                        child: Image.asset(controller.tabela[produto].icone),
                        width: 40,
                      ),
            title: Text(
              controller.tabela[produto].nome,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              controller.real.format(controller.tabela[produto].preco),
            ),
            selected:
                controller.selecionados.contains(controller.tabela[produto]),
            selectedTileColor: Colors.blueGrey[50],
            onTap: () {
              if (controller.selecionados.isNotEmpty) {
                controller.setStateProdutos(produto);
              } else {
                controller.mostrarDetalhes(context, controller.tabela[produto]);
              }
            },
            onLongPress: () {
              if (controller.selecionados.isEmpty) {
                controller.setStateProdutos(produto);
              }
            },
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, __) => Divider(),
        itemCount: controller.tabela.length,
      ),
      floatingActionButton: controller.selecionados.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                controller.checkoutCarrinho(context, controller.selecionados);
              },
              label: Icon(Icons.add_shopping_cart),
            )
          : null,
    );
  }
}
