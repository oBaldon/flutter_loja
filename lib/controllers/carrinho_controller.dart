import 'package:flutter_application/models/produto.dart';
import 'package:flutter_application/repositories/carrinho_repository.dart';
import 'package:provider/provider.dart';

class CarrinhoController {
  late CarrinhoRepository carrinho;

  void atualizarCarrinho(context, Produto produto) {
    Provider.of<CarrinhoRepository>(context, listen: false).remove(produto);
  }
}
