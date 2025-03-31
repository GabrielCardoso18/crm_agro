import 'package:crm_agro/cliente/cliente.dart';
import 'package:crm_agro/venda_item/venda_item.dart';

class Venda {

  int id;
  Cliente cliente;
  String? numero;
  String? observacoes;
  double? quantidade;
  double? valorUnitario;
  double? valorTotal;
  DateTime? dataCadastro;
  List<VendaItem> itens;

  Venda({required this.id, required this.cliente, required this.itens,
    this.numero, this.dataCadastro, this.observacoes, this.valorTotal,
    this.valorUnitario, this.quantidade});


}