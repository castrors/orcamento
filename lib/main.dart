import 'package:flutter/material.dart';
import 'package:orcamento/data/records_repository.dart';
import 'package:orcamento/data/records_repository_impl.dart';
import 'package:orcamento/screens/record_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var repository = RecordsRepositoryImpl();
  await repository.initDatabase();
  runApp(App(repository));
}

class App extends StatelessWidget {
  final RecordsRepository repository;
  App(this.repository);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orçamento',
      theme:
          ThemeData(primarySwatch: Colors.blue, accentColor: Colors.pinkAccent),
      home: RecordListScreen(repository),
    );
  }
}
