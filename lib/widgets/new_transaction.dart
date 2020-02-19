import 'package:expenses_app/widgets/adaptive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx) {
    print('Constructor NewTransaction Widget');
  }

  @override
  _NewTransactionState createState() {
    print('CreateState NewTransaction Widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print('Constructor _NewTransactionState');
  }

  @override
  void initState() {
    print('initState _NewTransactionState');
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    print('didUpdateWidget _NewTransactionState');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose _NewTransactionState');
    super.dispose();
  }

  void _submitData() {
    if (_titleController.text.isEmpty || _titleController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    if (Platform.isIOS) {
      double availableHeight = MediaQuery.of(context).size.height;
      setState(() {
        _selectedDate = DateTime.now();
      });
      showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          builder: (BuildContext builder) {
            return Container(
              height: availableHeight * 0.33,
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  CupertinoButton(
                    child: Text('Done'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ]),
                Container(
                    height: availableHeight * 0.25,
                    child: CupertinoDatePicker(
                      onDateTimeChanged: (pickedDate) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      },
                      initialDateTime: DateTime.now(),
                      maximumDate: DateTime.now(),
                      minimumDate: DateTime(2019),
                    )),
              ]),
            );
          });
    } else {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      });
    }
  }

  Widget getTextField(
      String title, TextEditingController txtController, TextInputType type) {
    return Platform.isIOS
        ? CupertinoTextField(
            placeholder: title,
            controller: txtController,
            keyboardType: type,
            onSubmitted: (_) => _submitData(),
          )
        : TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleController,
            keyboardType: type,
            onSubmitted: (_) => _submitData(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              getTextField('Title', _titleController, TextInputType.text),
              if (Platform.isIOS) SizedBox(height: 8),
              getTextField('Amount', _amountController,
                  TextInputType.numberWithOptions(decimal: true)),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    AdaptiveFlatButton('Chose Date!', _presentDatePicker),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitData,
                child: Text('Add Transaction'),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
