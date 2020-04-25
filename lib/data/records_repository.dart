import 'package:orcamento/data/record.dart';

abstract class RecordsRepository{

  Future<Record> save(Record record);
  Future<int> update(Record record);
  Future<int> delete(Record record);
  Future<List<Record>> getRecords();

}