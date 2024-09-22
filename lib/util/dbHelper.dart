import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../model/Tennis.dart';

class DbHelper {
  // Atributos: o nome da tabela e os nomes das colunas:
  String tblTennis = "tennis";
  String colId = "id";
  String colModelo = "modelo";
  String colMarca = "marca";
  String colTamanho = "tamanho";

  // Construtor nomeado.
  DbHelper._internal();

  // Cria o atributo _dbHelper
  static final DbHelper _dbHelper = DbHelper._internal();

  // Construtor do tipo FACTORY.
  factory DbHelper() {
    return _dbHelper;
  }

  // Este método vai retornar um objeto Future, da classe Database.
  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "tennis.db";
    var dbTennis = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTennis;
  }

  // Método que vai ser chamado se o banco de dados não existir.
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblTennis($colId INTEGER PRIMARY KEY, $colModelo TEXT, " +
            "$colMarca TEXT, $colTamanho TEXT)");
  }

  // Atributo para a referência do banco de dados:
  static Database? _db;

  // Criando um "getter" para o atributo acima.
  Future<Database> get db async {
    _db ??= await initializeDb();
    return _db!;
  }

  // Método para inserir dados no banco.
  Future<int> insertTennis(Tennis tennis) async {
    Database db = await this.db;
    var result = await db.insert(tblTennis, tennis.toMap());
    return result;
  }

  // Recuperar todos os registros.
  Future<List> getTennis() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblTennis");
    return result;
  }

  // Recuperar o número de registros da tabela.
  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("select count (*) from $tblTennis")
    );
    return result!;
  }

  // Método para atualizar registro.
  Future<int> updateTennis(Tennis tennis) async {
    var db = await this.db;
    var result = await db.update(tblTennis,
        tennis.toMap(),
        where: "$colId = ?",
        whereArgs: [tennis.id]);
    return result;
  }

  // Método para apagar registro.
  Future<int> deleteTennis(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete('DELETE FROM $tblTennis WHERE $colId = $id');
    return result;
  }
}