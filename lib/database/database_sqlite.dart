import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseSqlite {
  Future<Database> openConnection() async {
    final databasePath = await getDatabasesPath();
    final databaseFinalPath = join(databasePath, 'SQLITE_EXAMPLE');

    return await openDatabase(
      databaseFinalPath,
      version: 1,
      onConfigure: (Database db) async {
        await db.execute(
          'PRAGMA foreign_keys = ON',
        );
      },
      onCreate: (Database db, int version) {
        final batch = db.batch();
        batch.execute('''
           create table teste(
             id integer primary key autoincrement,
             nome varchar(200)
           )
         ''');
        batch.commit();
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) {},
      onDowngrade: (Database db, int oldVersion, int newVersion) {},
    );
  }
}
