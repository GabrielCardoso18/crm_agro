import 'package:crm_agro/cliente/cliente.dart';
import 'package:crm_agro/database/database_provider.dart';
import 'package:crm_agro/item/item.dart';

class ItemDAO {
  final dbProvider = DataBaseProvider.instance;

  Future<bool> salvar(Item item) async {
    final db = await dbProvider.database;
    final valores = item.toMap();
    if (item.id == null) {
      item.id = await db.insert(Item.nomeTabela, valores);
      return true;
    } else {
      final _registrosAtualizados = await db.update(Item.nomeTabela, valores,
          where: '${Item.CAMPO_ID} = ?', whereArgs: [item.id]);
      return _registrosAtualizados > 0;
    }
  }

  Future<bool> remover(int id) async {
    final db = await dbProvider.database;
    final registrosRemovidos = await db.delete(Item.nomeTabela, where:
    '${Item.CAMPO_ID} = ?', whereArgs: [id]);
    return registrosRemovidos > 0;
  }

  Future<List<Item>> listar({
    String filtro = '',
    String campoOrdencao = Item.CAMPO_ID,
    bool usarOrdemDecrescente = false,
  }) async{
    String? where;
    if(filtro.isNotEmpty) {
      where = "UPPER(${Item.CAMPO_DESCRICAO}) LIKE '${filtro.toUpperCase()}'";
    }
    var orderBy = campoOrdencao;
    if(usarOrdemDecrescente) {
      orderBy += ' DESC';
    }
    final db = await dbProvider.database;
    final resultado = await db.query(Item.nomeTabela, columns: [
      Item.CAMPO_ID, Item.CAMPO_DESCRICAO
    ], where: where,
        orderBy: orderBy);
    return resultado.map((m) => Item.fromMap(m)).toList();
  }
}