import 'package:crm_agro/cliente/cliente.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseProvider {
  static const _dbNome = 'crm-agro.db';
  static const _dbVersion = 5;

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
            ${Cliente.CAMPO_DATA_CADASTRO} TEXT,
            ${Cliente.CAMPO_TELEFONE} TEXT,
            ${Cliente.CAMPO_NUMERO} TEXT,
            ${Cliente.CAMPO_WHATSAPP} TEXT,
            ${Cliente.CAMPO_EMAIL} TEXT,
            ${Cliente.CAMPO_CELULAR} TEXT,
            ${Cliente.CAMPO_UF} TEXT,
            ${Cliente.CAMPO_ENDERECO} TEXT,
            ${Cliente.CAMPO_COMPLEMENTO} TEXT,
            ${Cliente.CAMPO_CIDADE} TEXT,
            ${Cliente.CAMPO_BAIRRO} TEXT
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