
class Item {

  int id;
  String descricao;
  String unidade;
  String? codigo;
  double valorUnitario;

  Item({required this.id, required this.descricao, required this.unidade, required this.valorUnitario, this.codigo});

}