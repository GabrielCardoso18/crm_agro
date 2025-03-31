

import 'package:crm_agro/cliente/cliente.dart';

class ClienteContato{

  int id;
  Cliente cliente;
  String? telefone;
  String? celular;
  String? whatsapp;
  String? email;

  ClienteContato({required this.id, required this.cliente, this.celular, this.email, this.telefone, this.whatsapp});

}