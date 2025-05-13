import 'package:crm_agro/cliente/cliente.dart';

class ClienteEndereco{

  static const CAMPO_ID = 'id';
  static const CAMPO_CLIENTE = 'idcliente';
  static const CAMPO_ENDERECO = 'endereco';
  static const CAMPO_BAIRRO = 'bairro';
  static const CAMPO_UF = 'uf';
  static const CAMPO_NUMERO = 'numero';
  static const CAMPO_CIDADE = 'cidade';
  static const CAMPO_COMPLEMENTO = 'complemento';
  static const nomeTabela = 'cliente_endereco';

  int? id;
  Cliente? cliente;
  String? endereco;
  String? bairro;
  String? uf;
  String? numero;
  String? cidade;
  String? complemento;

  ClienteEndereco({this.id,  this.cliente,  this.endereco,
     this.uf,  this.cidade, this.bairro, this.complemento, this.numero});

  Map<String, dynamic> toMap() => <String, dynamic>{
    CAMPO_ID: id,
    CAMPO_ENDERECO: endereco,
    CAMPO_BAIRRO: bairro,
    CAMPO_UF: uf,
    CAMPO_NUMERO: numero,
    CAMPO_CIDADE: cidade,
    CAMPO_COMPLEMENTO: complemento,
    CAMPO_CLIENTE: cliente?.toMap(),
  };

  factory ClienteEndereco.fromMap(Map<String, dynamic> map) =>
      ClienteEndereco(
        id: map[CAMPO_ID] is int ? map[CAMPO_ID] : null,
        endereco: map[CAMPO_ENDERECO] is String ? map[CAMPO_ENDERECO] : '',
        bairro: map[CAMPO_BAIRRO] is String ? map[CAMPO_BAIRRO] : '',
        uf: map[CAMPO_UF] is String ? map[CAMPO_UF] : '',
        numero: map[CAMPO_NUMERO] is String ? map[CAMPO_NUMERO] : '',
        cidade: map[CAMPO_CIDADE] is String ? map[CAMPO_CIDADE] : '',
        complemento: map[CAMPO_COMPLEMENTO] is String ? map[CAMPO_COMPLEMENTO] : '',
        cliente: map[CAMPO_CLIENTE] != null && map[CAMPO_CLIENTE] is Map<String, dynamic>
            ? Cliente.fromMap(map[CAMPO_CLIENTE])
            : null,
      );

}