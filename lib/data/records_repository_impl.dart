import 'package:orcamento/data/constants.dart';
import 'package:orcamento/data/record.dart';
import 'package:orcamento/data/records_repository.dart';
import 'package:sqflite/sqflite.dart';

class RecordsRepositoryImpl implements RecordsRepository {
  Database database;

  initDatabase() async {
    database = await openDatabase(databaseName, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $tableName ($id_column INTEGER PRIMARY KEY, $amount_column REAL, $description_column TEXT, $date_column TEXT, $isExpense_column INTEGER)');
    });
  }

  @override
  Future<int> delete(Record record) async {
    //DELETE FROM record WHERE id = ${record.id}
    return await database
        .delete(tableName, where: '$id_column = ?', whereArgs: [record.id]);
  }

  @override
  Future<List<Record>> getRecords() async {
    //SELECT * FROM record
    List<Record> records = [];
    List<Map> queryResult = await database.query(tableName);
    
    for (var query in queryResult) {
      var record = Record.fromMap(query);
      records.add(record);
    }

    return records;
  }

  @override
  Future<Record> save(Record record) async {
    //INSERT INTO record(amount, description, date, is_expense) VALUES(20.0, "Almoco", "2020-01-02T00:00:00.000", 1)
    record.id = await database.insert(tableName, record.toMap());
    return record;
  }

  @override
  Future<int> update(Record record) async {
     //UPDATE record SET amount = 30.0, description = "Janta", date = "2020-01-02T00:00:00.000", is_expense = 1 WHERE id = 1');
    return await database.update(tableName, record.toMap(),
        where: '$id_column = ?', whereArgs: [record.id]);
  }
}
