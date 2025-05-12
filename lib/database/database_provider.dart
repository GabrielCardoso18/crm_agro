import 'package:crm_agro/cliente/adicionar_cliente_page.dart';
import 'package:crm_agro/cliente/cliente.dart';
import 'package:crm_agro/cliente_contato/cliente_contato.dart';
import 'package:crm_agro/cliente_endereco/cliente_endereco.dart';
import 'package:crm_agro/item/item.dart';
import 'package:crm_agro/venda/venda.dart';
import 'package:crm_agro/venda_item/venda_item.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseProvider {
  static const _dbNome = 'crm-agro.db';
  static const _dbVersion = 1;

  DataBaseProvider._init();


  static final DataBaseProvider instance = DataBaseProvider._init();

  Database? _database;

  Future<Database> get database async {
    if(_database == null) {
      _database = await _initDataBase();
    }
    return _database!;
  }

  Future<Database> _initDataBase() async {
    String dataBasePath = await getDatabasesPath();
    String dbPath = '${dataBasePath}/${_dbNome}';
    return await openDatabase(
        dbPath,
        version: _dbVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
     
    ''');
  }

  Future<void> _onUpgrade(Database db, int newVersion, int oldVersion) async {
  }

  Future<void> close() async {
    if(_database != null) {
      await _database!.close();
    }
  }
}