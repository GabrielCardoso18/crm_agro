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
    String filtro = '',
    String campoOrdencao = Cliente.CAMPO_ID,
    bool usarOrdemDecrescente = false,
  }) async{
    String? where;
    if(filtro.isNotEmpty) {
      where = "UPPER(${Cliente.CAMPO_NOME_FANTASIA}) LIKE '${filtro.toUpperCase()}'";
    }
    var orderBy = campoOrdencao;
    if(usarOrdemDecrescente) {
      orderBy += ' DESC';
    }
    final db = await dbProvider.database;
    final resultado = await db.query(Cliente.nomeTabela, columns: [
      Cliente.CAMPO_ID, Cliente.CAMPO_NOME_FANTASIA, Cliente.CAMPO_RAZAO_SOCIAL, Cliente.CAMPO_CPFCNPJ
    ], where: where,
        orderBy: orderBy);
    return resultado.map((m) => Cliente.fromMap(m)).toList();
  }
}