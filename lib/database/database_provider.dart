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
      CREATE TABLE ${Cliente.nomeTabela} (
        ${Cliente.CAMPO_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Cliente.CAMPO_NOME_FANTASIA} TEXT NOT NULL,
        ${Cliente.CAMPO_RAZAO_SOCIAL} TEXT,
        ${Cliente.CAMPO_CPFCNPJ} TEXT,
        ${Cliente.CAMPO_DATA_CADASTRO} TEXT
      );
      CREATE TABLE ${Item.nomeTabela} (
        ${Item.CAMPO_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Item.CAMPO_DESCRICAO} TEXT NOT NULL,
        ${Item.CAMPO_CODIGO} TEXT,
        ${Item.CAMPO_VALOR_UNITARIO} NUMERIC,
        ${Item.CAMPO_UNIDADE} TEXT
      );
      CREATE TABLE ${Venda.nomeTabela} (
        ${Venda.CAMPO_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Venda.CAMPO_CLIENTE} INTEGER,
        ${Venda.CAMPO_NUMERO} TEXT,
        ${Venda.CAMPO_DATA_CADASTRO} TEXT,
        ${Venda.CAMPO_VALOR_TOTAL} NUMERIC,
        ${Venda.CAMPO_OBSERVACOES} TEXT,
        FOREIGN KEY (idcliente) REFERENCES cliente(id)
      );
      CREATE TABLE ${VendaItem.nomeTabela} (
        ${VendaItem.CAMPO_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${VendaItem.CAMPO_ITEM} INTEGER,
        ${VendaItem.CAMPO_VENDA} INTEGER,
        ${VendaItem.CAMPO_QUANTIDADE} NUMERIC,
        ${VendaItem.CAMPO_VALOR_UNITARIO} NUMERIC,
        ${VendaItem.CAMPO_VALOR_TOTAL} NUMERIC,
        FOREIGN KEY (iditem) REFERENCES item(id),
        FOREIGN KEY (idvenda) REFERENCES venda(id)
      );
      CREATE TABLE ${ClienteContato.nomeTabela} (
        ${ClienteContato.CAMPO_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${ClienteContato.CAMPO_CLIENTE} INTEGER,
        ${ClienteContato.CAMPO_CELULAR} TEXT,
        ${ClienteContato.CAMPO_EMAIL} TEXT,
        ${ClienteContato.CAMPO_TELEFONE} TEXT,
        ${ClienteContato.CAMPO_WHATSAPP} TEXT,
        FOREIGN KEY (idcliente) REFERENCES cliente(id)
      );
      CREATE TABLE ${ClienteEndereco.nomeTabela} (
        ${ClienteEndereco.CAMPO_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${ClienteEndereco.CAMPO_CLIENTE} INTEGER,
        ${ClienteEndereco.CAMPO_BAIRRO} TEXT,
        ${ClienteEndereco.CAMPO_CIDADE} TEXT,
        ${ClienteEndereco.CAMPO_COMPLEMENTO} TEXT,
        ${ClienteEndereco.CAMPO_ENDERECO} TEXT,
        ${ClienteEndereco.CAMPO_NUMERO} TEXT,
        ${ClienteEndereco.CAMPO_UF} TEXT,
        FOREIGN KEY (idcliente) REFERENCES cliente(id)
      );
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