import 'package:crm_agro/cliente/cliente.dart';
import 'package:crm_agro/database/database_provider.dart';

class ClienteDAO {
  final dbProvider = DataBaseProvider.instance;

  Future<bool> salvar(Cliente cliente) async {
    final db = await dbProvider.database;
    final valores = cliente.toMap();
    if (cliente.id == null) {
      cliente.id = await db.insert(Cliente.nomeTabela, valores);
      return true;
    } else {
      final _registrosAtualizados = await db.update(Cliente.nomeTabela, valores,
          where: '${Cliente.CAMPO_ID} = ?', whereArgs: [cliente.id]);
      return _registrosAtualizados > 0;
    }
  }

  Future<bool> remover(int id) async {
    final db = await dbProvider.database;
    final registrosRemovidos = await db.delete(Cliente.nomeTabela, where:
    '${Cliente.CAMPO_ID} = ?', whereArgs: [id]);
    return registrosRemovidos > 0;
  }

  Future<List<Cliente>> listar({
    String nomeFantasia = '',
    String razaoSocial = '',
    String cpfCnpj = '',
    String campoOrdencao = Cliente.CAMPO_ID,
    bool usarOrdemDecrescente = false,
  }) async{
    String? where;
    if(nomeFantasia.isNotEmpty) {
      where = " UPPER(${Cliente.CAMPO_NOME_FANTASIA}) LIKE '${nomeFantasia.toUpperCase()}'";
    }
    if(razaoSocial.isNotEmpty) {
      if(where!.isNotEmpty) {
        where = " AND UPPER(${Cliente.CAMPO_RAZAO_SOCIAL}) LIKE '${razaoSocial.toUpperCase()}'";
      } else {
        where = " UPPER(${Cliente.CAMPO_RAZAO_SOCIAL}) LIKE '${razaoSocial.toUpperCase()}'";
      }

    }if(cpfCnpj.isNotEmpty) {
      if(where!.isNotEmpty) {
        where = " AND UPPER(${Cliente.CAMPO_CPFCNPJ}) LIKE '${cpfCnpj.toUpperCase()}'";
      } else {
        where = " UPPER(${Cliente.CAMPO_CPFCNPJ}) LIKE '${cpfCnpj.toUpperCase()}'";
      }
    }
    var orderBy = campoOrdencao;
    if(usarOrdemDecrescente) {
      orderBy += ' DESC';
    }
    final db = await dbProvider.database;
    final resultado = await db.query(Cliente.nomeTabela, columns: [
      Cliente.CAMPO_ID, Cliente.CAMPO_NOME_FANTASIA, Cliente.CAMPO_RAZAO_SOCIAL, Cliente.CAMPO_CPFCNPJ,
      Cliente.CAMPO_BAIRRO, Cliente.CAMPO_CIDADE, Cliente.CAMPO_COMPLEMENTO, Cliente.CAMPO_ENDERECO,
      Cliente.CAMPO_UF, Cliente.CAMPO_CELULAR, Cliente.CAMPO_EMAIL, Cliente.CAMPO_WHATSAPP, Cliente.CAMPO_DATA_CADASTRO,
      Cliente.CAMPO_NUMERO
    ], where: where,
        orderBy: orderBy);
    return resultado.map((m) => Cliente.fromMap(m)).toList();
  }
}