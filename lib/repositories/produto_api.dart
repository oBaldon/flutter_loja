import 'dart:convert';
import 'package:flutter_application/models/produto.dart';
import 'package:http/http.dart' as http;

class ProdutoAPI {
  var baseUrl = Uri(
    scheme: 'http',
    host: '192.168.1.53',
    port: 8000,
    path: '/produtos',
  );

  Future<List<Produto>> getProdutos() async {
    var response = await http.get(baseUrl);

    if (response.statusCode == 200) {
      List<dynamic> produtosJson = jsonDecode(response.body);
      List<Produto> produtos = [];
      for (var produtoJson in produtosJson) {
        Produto produto = Produto(
          icone: produtoJson['icone'],
          nome: produtoJson['nome'],
          tipo: produtoJson['tipo'],
          preco: double.parse(produtoJson['preco'].toString()),
        );
        produtos.add(produto);
      }
      return produtos;
    } else {
      throw Exception('Falha ao carregar produtos');
    }
  }

  Future<void> adicionarProduto(Map<String, dynamic> produto) async {}

  Future<void> excluirProdutoPorNome(String nome) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/produtos/$nome'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao excluir produto');
    }
  }
}
