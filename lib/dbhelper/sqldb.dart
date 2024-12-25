import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqldb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'favouriteMovies.db');
    Database database = await openDatabase(path,
        version: 1, onCreate: _oncreate, onUpgrade: _onUpgrade);
    return database;
  }

  _oncreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
      CREATE TABLE favMovies(
      id INTEGER NOT NULL,
      title TEXT NOT NULL,
      year INTEGER NOT NULL,
      rating DECIMAL(2, 1) NOT NULL,
      imageUrl TEXT NOT NULL
      )
''');
    await batch.commit();
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future<List<Map>> readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  Future<int> insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
