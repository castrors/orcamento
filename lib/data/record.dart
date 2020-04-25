import 'package:orcamento/data/constants.dart';

class Record {
  int id;
  double amount = 0.0;
  String description;
  DateTime date;
  bool isExpense = false;

  Record();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      amount_column: amount,
      description_column: description,
      date_column: date.toIso8601String(),
      isExpense_column: isExpense == true ? 1 : 0
    };
    if (id != null) {
      map[id_column] = id;
    }
    return map;
  }

  Record.fromMap(Map<String, dynamic> map) {
    id = map[id_column];
    amount = map[amount_column];
    description = map[description_column];
    date = DateTime.parse(map[date_column]);
    isExpense = map[isExpense_column] == 1;
  }
}
