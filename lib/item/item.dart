
class Item {

  static const CAMPO_ID = '_id';
  static const CAMPO_DESCRICAO = 'descricao';
  static const CAMPO_UNIDADE = 'unidade';
  static const CAMPO_CODIGO = 'codigo';
  static const CAMPO_VALOR_UNITARIO = 'valorunitario';
  static const nomeTabela = 'item';

  int id;
  String descricao;
  String unidade;
  String? codigo;
  double valorUnitario;

  Item({required this.id, required this.descricao, required this.unidade, required this.valorUnitario, this.codigo});

  Map<String, dynamic> toMap() => <String, dynamic>{
    CAMPO_ID: id,
    CAMPO_DESCRICAO: descricao,
    CAMPO_UNIDADE: unidade,
    CAMPO_CODIGO: codigo,
    CAMPO_VALOR_UNITARIO : valorUnitario,
  };

  factory Item.fromMap(Map<String, dynamic> map) =>
      Item(
        id: map[CAMPO_ID] is int ? map[CAMPO_ID] : null,
        descricao: map[CAMPO_DESCRICAO] is String ? map[CAMPO_DESCRICAO] : '',
        unidade: map[CAMPO_UNIDADE] is String ? map[CAMPO_UNIDADE] : '',
        codigo: map[CAMPO_CODIGO] is String ? map[CAMPO_CODIGO] : '',
        valorUnitario: map[CAMPO_VALOR_UNITARIO] == null ? null :
          map[CAMPO_VALOR_UNITARIO],
      );

}