

import 'package:crm_agro/item/item.dart';
import 'package:crm_agro/venda/venda.dart';

class VendaItem {

  static const CAMPO_ID = 'id';
  static const CAMPO_ITEM = 'iditem';
  static const CAMPO_VENDA = 'idvenda';
  static const CAMPO_QUANTIDADE = 'quantidade';
  static const CAMPO_VALOR_UNITARIO = 'valorunitario';
  static const CAMPO_VALOR_TOTAL = 'valortotal';
  static const nomeTabela = 'venda_item';

  int? id;
  Venda? venda;
  Item? item;
  double? quantidade;
  double? valorUnitario;
  double? valorTotal;

  VendaItem({this.id, this.venda, this.item, this.quantidade,
    this.valorUnitario, this.valorTotal});

  Map<String, dynamic> toMap() => <String, dynamic>{
    CAMPO_ID: id,
    CAMPO_ITEM: item?.toMap(),
    CAMPO_VENDA: venda?.toMap(),
    CAMPO_QUANTIDADE: quantidade,
    CAMPO_VALOR_UNITARIO: valorUnitario,
    CAMPO_VALOR_TOTAL: valorTotal,
  };

  factory VendaItem.fromMap(Map<String, dynamic> map) =>
      VendaItem(
        id: map[CAMPO_ID] is int ? map[CAMPO_ID] : null,
        item: map[CAMPO_ITEM] != null && map[CAMPO_ITEM] is Map<String, dynamic>
            ? Item.fromMap(map[CAMPO_ITEM])
            : null,
        venda: map[CAMPO_VENDA] != null && map[CAMPO_VENDA] is Map<String, dynamic>
            ? Venda.fromMap(map[CAMPO_VENDA])
            : null,
        quantidade: map[CAMPO_QUANTIDADE],
        valorUnitario: map[CAMPO_VALOR_UNITARIO],
        valorTotal: map[CAMPO_VALOR_TOTAL],
      );

}