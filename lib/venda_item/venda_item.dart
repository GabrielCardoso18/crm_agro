

import 'package:crm_agro/item/item.dart';

class VendaItem {

  int id;
  Item item;
  double quantidade;
  double valorUnitario;
  double valorTotalItem;

  VendaItem({required this.id, required this.item, required this.quantidade, required this.valorUnitario, required this.valorTotalItem});
}