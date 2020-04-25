import 'package:flutter/material.dart';
import 'package:orcamento/data/record.dart';
import 'package:orcamento/data/records_repository.dart';
import 'package:orcamento/screens/record_detail_screen.dart';
import 'package:orcamento/widget/record_item_widget.dart';

class RecordListScreen extends StatefulWidget {
  final RecordsRepository repository;
  RecordListScreen(this.repository);

  @override
  _RecordListScreenState createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<RecordListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Registros'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          navigateToDetail(widget.repository, Record());
        },
      ),
      body: FutureBuilder(
          future: widget.repository.getRecords(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Record>> snapshot) {
            if (snapshot.hasData) {
              List<Record> results = snapshot.data;
              return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (BuildContext context, int index) {
                    var record = results[index];
                    return RecordItemWidget(
                      widget.repository,
                      record,
                      onTap: () {
                        navigateToDetail(widget.repository, record);
                      },
                    );
                  });
            }
            if (snapshot.hasError) {
              return Text('Deu ruim!');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return Text('Banco vazio!');
            }
            return CircularProgressIndicator();
          }),
    );
  }

  void navigateToDetail(repository, Record record) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RecordDetailScreen(repository, record)),
    );
  }
}
