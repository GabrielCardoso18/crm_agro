import 'package:crm_agro/cliente_contato/cliente_contato.dart';
import 'package:crm_agro/cliente_endereco/cliente_endereco.dart';
import 'package:intl/intl.dart';

class Cliente{

  static const CAMPO_ID = '_id';
  static const CAMPO_NOME_FANTASIA = 'nomefantasia';
  static const CAMPO_RAZAO_SOCIAL = 'razaosocial';
  static const CAMPO_CPFCNPJ = 'cpfcnpj';
  static const CAMPO_DATA_CADASTRO = 'datacadastro';
  static const CAMPO_CONTATO = 'contato';
  static const CAMPO_ENDERECO = 'endereco';
  static const nomeTabela = 'cliente';

  int? id;
  String? nomeFantasia;
  String razaoSocial;
  DateTime? dataCadastro;
  String cpfCnpj;
  ClienteContato? contato;
  ClienteEndereco? endereco;

  Cliente({this.id, required this.razaoSocial, required this.cpfCnpj,
    this.nomeFantasia,  this.contato, this.dataCadastro, this.endereco});

  Map<String, dynamic> toMap() => <String, dynamic>{
    CAMPO_ID: id,
    CAMPO_NOME_FANTASIA: nomeFantasia,
    CAMPO_RAZAO_SOCIAL: razaoSocial,
    CAMPO_CPFCNPJ: cpfCnpj,
    CAMPO_DATA_CADASTRO : dataCadastro == null ? null :
    DateFormat('dd/MM/yyyy').format(dataCadastro!),
    CAMPO_CONTATO: contato?.toMap(),
    CAMPO_ENDERECO: endereco?.toMap(),
  };

  factory Cliente.fromMap(Map<String, dynamic> map) =>
      Cliente(
        id: map[CAMPO_ID] is int ? map[CAMPO_ID] : null,
        nomeFantasia: map[CAMPO_NOME_FANTASIA] is String ? map[CAMPO_NOME_FANTASIA] : '',
        razaoSocial: map[CAMPO_RAZAO_SOCIAL] is String ? map[CAMPO_RAZAO_SOCIAL] : '',
        cpfCnpj: map[CAMPO_CPFCNPJ] is String ? map[CAMPO_CPFCNPJ] : '',
        dataCadastro: map[CAMPO_DATA_CADASTRO] == null ? null :
        DateFormat("dd/MM/yyyy").parse(map[CAMPO_DATA_CADASTRO]),
        contato: map[CAMPO_CONTATO] != null && map[CAMPO_CONTATO] is Map<String, dynamic>
          ? ClienteContato.fromMap(map[CAMPO_CONTATO])
        : null,
        endereco: map[CAMPO_ENDERECO] != null && map[CAMPO_ENDERECO] is Map<String, dynamic>
            ? ClienteEndereco.fromMap(map[CAMPO_ENDERECO])
            : null,
      );
}