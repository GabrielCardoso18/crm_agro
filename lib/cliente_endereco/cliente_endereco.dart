import 'package:crm_agro/cliente/cliente.dart';

class ClienteEndereco{

  int id;
  Cliente cliente;
  String endereco;
  String? bairro;
  String uf;
  String? numero;
  String cidade;
  String? complemento;

  ClienteEndereco({required this.id, required this.cliente, required this.endereco,
    required this.uf, required this.cidade, this.bairro, this.complemento, this.numero});

}