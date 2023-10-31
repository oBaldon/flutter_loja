import 'package:flutter/material.dart';
import 'package:flutter_application/pages/carrinho_page.dart';
import 'package:flutter_application/pages/store_page.dart';
import 'package:flutter_application/models/produto.dart';
import 'package:flutter_application/pages/usuario_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Produto> carrinho = [];
  int pagAtual = 0;
  late PageController paginaController;

  @override
  void initState() {
    super.initState();
    paginaController = PageController(initialPage: pagAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      pagAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: paginaController,
        children: [
          StorePage(),
          CarrinhoPage(),
          UsuarioPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pagAtual,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Carrinho'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Usuário'),
        ],
        onTap: (pagina) {
          paginaController.animateToPage(pagina,
              duration: Duration(milliseconds: 400), curve: Curves.ease);
        },
        backgroundColor: Colors.grey[100],
      ),
    );
  }
}
