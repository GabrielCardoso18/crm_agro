import 'package:crm_agro/cliente_contato/cliente_contato.dart';
import 'package:crm_agro/cliente_endereco/cliente_endereco.dart';

class Cliente{

  int id;
  String? nomeFantasia;
  String razaoSocial;
  DateTime? dataCadastro;
  String cpfCnpj;
  List<ClienteContato>? contatos;
  List<ClienteEndereco>? enderecos;

  Cliente({required this.id, required this.razaoSocial, required this.cpfCnpj,
    this.nomeFantasia,  this.contatos, this.dataCadastro, this.enderecos});
}