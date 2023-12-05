from flask import Flask, jsonify, request
from produto_repository import Produto, ProdutoRepository

app = Flask(__name__)
produto_repo = ProdutoRepository()

@app.route('/produtos', methods=['GET'])
def get_produtos():
    produtos = produto_repo.get_all()
    produtos_dict = [produto.__dict__ for produto in produtos]
    return jsonify(produtos_dict)

@app.route('/produtos/<string:nome>', methods=['GET'])
def get_produto_por_nome(nome):
    produto = produto_repo.get_by_name(nome)
    if produto:
        return jsonify(produto.__dict__)
    return jsonify({'message': 'Produto não encontrado'}), 404

@app.route('/produtos', methods=['POST'])
def add_produto():
    data = request.json
    novo_produto = Produto(
        icone=data['icone'],
        nome=data['nome'],
        tipo=data['tipo'],
        preco=data['preco']
    )
    produto_repo.add(novo_produto)
    return jsonify({'message': 'Produto adicionado com sucesso'})

@app.route('/produtos/<string:nome>', methods=['DELETE'])
def delete_produto_por_nome(nome):
    deleted = produto_repo.delete_by_name(nome)
    if deleted:
        return jsonify({'message': 'Produto excluído com sucesso'})
    return jsonify({'message': 'Produto não encontrado'}), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=True)
