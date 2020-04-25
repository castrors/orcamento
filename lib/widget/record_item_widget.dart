import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:orcamento/data/record.dart';
import 'package:orcamento/data/records_repository.dart';

class RecordItemWidget extends StatelessWidget {
  final RecordsRepository repository;
  final Record record;
  final Function onTap;

  RecordItemWidget(this.repository, this.record, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: record.isExpense ? Colors.red : Colors.green,
        ),
        title: Text(record.description),
        subtitle: Text(record.amount.toString()),
        trailing: Text(DateFormat('dd/MM/yyyy').format(record.date)),
        onTap: onTap,
      ),
      key: UniqueKey(),
      onDismissed: (DismissDirection direction) {
        repository.delete(record);
      },
    );
  }
}
