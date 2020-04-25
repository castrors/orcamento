import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:orcamento/data/record.dart';
import 'package:orcamento/data/records_repository.dart';

class RecordDetailScreen extends StatefulWidget {
  final RecordsRepository repository;
  final Record record;
  RecordDetailScreen(this.repository, this.record);

  @override
  _RecordDetailScreenState createState() => _RecordDetailScreenState();
}

class _RecordDetailScreenState extends State<RecordDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  Record _record;

  @override
  void initState() {
    super.initState();
    _record = widget.record;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_record.id == null ? 'Novo Registro' : 'Editar Registro'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();

              if (_record.id == null) {
                widget.repository.save(_record);
              } else {
                widget.repository.update(_record);
              }

              Navigator.pop(context);
            }
          },
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _record.amount.toString(),
                  decoration: InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Favor digitar o valor do registro';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    _record.amount = double.parse(value);
                  },
                ),
                TextFormField(
                  initialValue: _record.description,
                  decoration: InputDecoration(labelText: 'Descrição'),
                  validator: (String desciption) {
                    if (desciption.isEmpty) {
                      return 'Favor digitar a descrição do registro';
                    }
                    return null;
                  },
                  onSaved: (String description) {
                    _record.description = description;
                  },
                ),
                DateTimeField(
                  initialValue: _record.date,
                  decoration: InputDecoration(labelText: 'Data'),
                  format: DateFormat("dd/MM/yyyy"),
                  validator: (DateTime value) {
                    if (value == null) {
                      return 'Favor selecionar a data do registro';
                    }
                    return null;
                  },
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                  onSaved: (DateTime date) {
                    _record.date = date;
                  },
                ),
                SwitchListTile(
                  value: _record.isExpense,
                  title: Text(_record.isExpense ? 'Despesa' : 'Receita'),
                  onChanged: (bool value) {
                    setState(() {
                      _record.isExpense = value;
                    });
                  },
                )
              ],
            ),
          ),
        ));
  }
}
