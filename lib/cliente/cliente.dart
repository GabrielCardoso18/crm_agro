import 'package:intl/intl.dart';

class Cliente{

  static const CAMPO_ID = 'id';
  static const CAMPO_NOME_FANTASIA = 'nomefantasia';
  static const CAMPO_RAZAO_SOCIAL = 'razaosocial';
  static const CAMPO_CPFCNPJ = 'cpfcnpj';
  static const CAMPO_DATA_CADASTRO = 'datacadastro';
  static const CAMPO_TELEFONE = 'telefone';
  static const CAMPO_CELULAR = 'celular';
  static const CAMPO_WHATSAPP = 'whatsapp';
  static const CAMPO_EMAIL = 'email';
  static const CAMPO_ENDERECO = 'endereco';
  static const CAMPO_BAIRRO = 'bairro';
  static const CAMPO_UF = 'uf';
  static const CAMPO_NUMERO = 'numero';
  static const CAMPO_CIDADE = 'cidade';
  static const CAMPO_COMPLEMENTO = 'complemento';
  static const nomeTabela = 'cliente';

  int? id;
  String? nomeFantasia;
  String razaoSocial;
  DateTime? dataCadastro;
  String cpfCnpj;
  String? telefone;
  String? celular;
  String? whatsapp;
  String? email;
  String? endereco;
  String? bairro;
  String? uf;
  String? numero;
  String? cidade;
  String? complemento;

  Cliente({this.id, required this.razaoSocial, required this.cpfCnpj,
    this.nomeFantasia, this.dataCadastro, this.numero, this.endereco,
    this.uf, this.bairro, this.complemento, this.cidade, this.whatsapp,
    this.celular, this.telefone, this.email
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
    CAMPO_ID: id,
    CAMPO_NOME_FANTASIA: nomeFantasia,
    CAMPO_RAZAO_SOCIAL: razaoSocial,
    CAMPO_CPFCNPJ: cpfCnpj,
    CAMPO_DATA_CADASTRO : dataCadastro == null ? null :
    DateFormat('dd/MM/yyyy').format(dataCadastro!),
    CAMPO_TELEFONE: telefone,
    CAMPO_CELULAR: celular,
    CAMPO_WHATSAPP: whatsapp,
    CAMPO_EMAIL: email,
    CAMPO_ENDERECO: endereco,
    CAMPO_BAIRRO: bairro,
    CAMPO_UF: uf,
    CAMPO_NUMERO: numero,
    CAMPO_CIDADE: cidade,
    CAMPO_COMPLEMENTO: complemento
  };

  factory Cliente.fromMap(Map<String, dynamic> map) =>
      Cliente(
        id: map[CAMPO_ID] is int ? map[CAMPO_ID] : null,
        nomeFantasia: map[CAMPO_NOME_FANTASIA] is String ? map[CAMPO_NOME_FANTASIA] : '',
        razaoSocial: map[CAMPO_RAZAO_SOCIAL] is String ? map[CAMPO_RAZAO_SOCIAL] : '',
        cpfCnpj: map[CAMPO_CPFCNPJ] is String ? map[CAMPO_CPFCNPJ] : '',
        dataCadastro: map[CAMPO_DATA_CADASTRO] == null ? null :
        DateFormat("dd/MM/yyyy").parse(map[CAMPO_DATA_CADASTRO]),
        telefone: map[CAMPO_TELEFONE] is String ? map[CAMPO_TELEFONE] : '',
        celular: map[CAMPO_TELEFONE] is String ? map[CAMPO_TELEFONE] : '',
        cidade: map[CAMPO_TELEFONE] is String ? map[CAMPO_TELEFONE] : '',
        complemento: map[CAMPO_TELEFONE] is String ? map[CAMPO_TELEFONE] : '',
        numero: map[CAMPO_TELEFONE] is String ? map[CAMPO_TELEFONE] : '',
        bairro: map[CAMPO_TELEFONE] is String ? map[CAMPO_TELEFONE] : '',
        endereco: map[CAMPO_TELEFONE] is String ? map[CAMPO_TELEFONE] : '',
        email: map[CAMPO_TELEFONE] is String ? map[CAMPO_TELEFONE] : '',
        whatsapp: map[CAMPO_TELEFONE] is String ? map[CAMPO_TELEFONE] : '',
        uf: map[CAMPO_TELEFONE] is String ? map[CAMPO_TELEFONE] : '',

      );
}