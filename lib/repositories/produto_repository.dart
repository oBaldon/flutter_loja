import 'package:flutter_application/models/produto.dart';

class ProdutoRepository {
  static List<Produto> tabela = [
    Produto(
      icone: 'images/placa-de-video.png',
      nome: 'Placa de Vídeo',
      tipo: 'GPU',
      preco: 1290.50,
    ),
    Produto(
      icone: 'images/placa-mae.png',
      nome: 'Placa Mãe',
      tipo: 'MOBO',
      preco: 999.99,
    ),
    Produto(
      icone: 'images/processador.png',
      nome: 'Processador',
      tipo: 'CPU',
      preco: 2130.20,
    ),
    Produto(
      icone: 'images/memoria-ram.png',
      nome: 'Memória RAM',
      tipo: 'RAM',
      preco: 250.00,
    ),
    Produto(
      icone: 'images/fonte.png',
      nome: 'Fonte de Energia',
      tipo: 'Fonte',
      preco: 550.80,
    ),
    Produto(
      icone: 'images/hd.png',
      nome: 'Hard Disk',
      tipo: 'HDD',
      preco: 280.90,
    ),
    Produto(
      icone: 'images/cooler.png',
      nome: 'Cooler',
      tipo: 'FAN',
      preco: 20.65,
    ),
  ];
}
