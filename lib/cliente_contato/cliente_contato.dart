

import 'package:crm_agro/cliente/cliente.dart';

class ClienteContato{

  static const CAMPO_ID = 'id';
  static const CAMPO_CLIENTE = 'idcliente';
  static const CAMPO_TELEFONE = 'telefone';
  static const CAMPO_CELULAR = 'celular';
  static const CAMPO_WHATSAPP = 'whatsapp';
  static const CAMPO_EMAIL = 'email';
  static const nomeTabela = 'cliente_contato';

  int? id;
  Cliente? cliente;
  String? telefone;
  String? celular;
  String? whatsapp;
  String? email;

  ClienteContato({this.id, this.cliente, this.celular, this.email, this.telefone, this.whatsapp});


  Map<String, dynamic> toMap() => <String, dynamic>{
    CAMPO_ID: id,
    CAMPO_TELEFONE: telefone,
    CAMPO_CELULAR: celular,
    CAMPO_WHATSAPP: whatsapp,
    CAMPO_EMAIL: email,
    CAMPO_CLIENTE: cliente?.toMap(),
  };

  factory ClienteContato.fromMap(Map<String, dynamic> map) =>
      ClienteContato(
        id: map[CAMPO_ID] is int ? map[CAMPO_ID] : null,
        telefone: map[CAMPO_TELEFONE] is String ? map[CAMPO_TELEFONE] : '',
        celular: map[CAMPO_CELULAR] is String ? map[CAMPO_CELULAR] : '',
        whatsapp: map[CAMPO_WHATSAPP] is String ? map[CAMPO_WHATSAPP] : '',
        email: map[CAMPO_EMAIL] is String ? map[CAMPO_EMAIL] : '',
        cliente: map[CAMPO_CLIENTE] != null && map[CAMPO_CLIENTE] is Map<String, dynamic>
            ? Cliente.fromMap(map[CAMPO_CLIENTE])
            : null,
      );

}