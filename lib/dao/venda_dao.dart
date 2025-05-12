import 'package:crm_agro/cliente/cliente.dart';
import 'package:crm_agro/database/database_provider.dart';
import 'package:crm_agro/venda/venda.dart';

class VendaDAO {
  final dbProvider = DataBaseProvider.instance;

  Future<bool> salvar(Venda venda) async {
    final db = await dbProvider.database;
    final valores = venda.toMap();
    if (venda.id == null) {
      venda.id = await db.insert(Cliente.nomeTabela, valores);
      return true;
    } else {
      final _registrosAtualizados = await db.update(Cliente.nomeTabela, valores,
          where: '${Cliente.CAMPO_ID} = ?', whereArgs: [venda.id]);
      return _registrosAtualizados > 0;
    }
  }

  Future<bool> remover(int id) async {
    final db = await dbProvider.database;
    final registrosRemovidos = await db.delete(Venda.nomeTabela, where:
    '${Venda.CAMPO_ID} = ?', whereArgs: [id]);
    return registrosRemovidos > 0;
  }

  Future<List<Venda>> listar({
    String filtro = '',
    String campoOrdencao = Venda.CAMPO_ID,
    bool usarOrdemDecrescente = false,
  }) async{
    String? where;
    if(filtro.isNotEmpty) {
      where = "UPPER(${Venda.CAMPO_DATA_CADASTRO}) LIKE '${filtro.toUpperCase()}'";
    }
    var orderBy = campoOrdencao;
    if(usarOrdemDecrescente) {
      orderBy += ' DESC';
    }
    final db = await dbProvider.database;
    final resultado = await db.query(Venda.nomeTabela, columns: [
      Venda.CAMPO_ID
    ], where: where,
        orderBy: orderBy);
    return resultado.map((m) => Venda.fromMap(m)).toList();
  }
}