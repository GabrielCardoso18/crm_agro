import 'package:crm_agro/cliente/cliente.dart';
import 'package:crm_agro/item/item.dart';
import 'package:crm_agro/venda_item/venda_item.dart';
import 'package:intl/intl.dart';

class Venda {

  static const CAMPO_ID = '_id';
  static const CAMPO_CLIENTE = 'cliente';
  static const CAMPO_NUMERO = 'numero';
  static const CAMPO_OBSERVACOES = 'observacoes';
  static const CAMPO_QUANTIDADE = 'quantidade';
  static const CAMPO_VALOR_UNITARIO = 'valorunitario';
  static const CAMPO_VALOR_TOTAL = 'valortotal';
  static const CAMPO_DATA_CADASTRO = 'datacadastro';
  static const CAMPO_VENDA_ITENS = 'itens';
  static const nomeTabela = 'venda';

  int? id;
  Cliente? cliente;
  String? numero;
  String? observacoes;
  double? valorTotal;
  DateTime? dataCadastro;
  List<VendaItem>? itens;

  Venda({this.id, required this.cliente, required this.itens,
    this.numero, this.dataCadastro, this.observacoes, this.valorTotal});

  Map<String, dynamic> toMap() => <String, dynamic>{
    CAMPO_ID: id,
    CAMPO_CLIENTE: cliente?.toMap(),
    CAMPO_NUMERO: numero,
    CAMPO_OBSERVACOES: observacoes,
    CAMPO_VALOR_TOTAL: valorTotal,
    CAMPO_DATA_CADASTRO: dataCadastro != null
        ? DateFormat('dd/MM/yyyy').format(dataCadastro!)
        : null,
    CAMPO_VENDA_ITENS: itens?.map((item) => item.toMap()).toList(),
  };

  factory Venda.fromMap(Map<String, dynamic> map) =>
      Venda(
        id: map[CAMPO_ID] is int ? map[CAMPO_ID] : null,
        cliente: map[CAMPO_CLIENTE] != null && map[CAMPO_CLIENTE] is Map<String, dynamic>
            ? Cliente.fromMap(map[CAMPO_CLIENTE])
            : null,
        numero: map[CAMPO_NUMERO] is String ? map[CAMPO_NUMERO] : '',
        observacoes: map[CAMPO_OBSERVACOES] is String ? map[CAMPO_OBSERVACOES] : '',
        valorTotal: map[CAMPO_VALOR_TOTAL],
        dataCadastro: map[CAMPO_DATA_CADASTRO] == null ? null :
          DateFormat("dd/MM/yyyy").parse(map[CAMPO_DATA_CADASTRO]),
        itens: map['itens'] != null && map['itens'] is List
            ? List<VendaItem>.from(
            map['itens'].map((item) => VendaItem.fromMap(item as Map<String, dynamic>)))
            : [],
      );

}