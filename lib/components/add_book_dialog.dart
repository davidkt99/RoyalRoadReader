import 'package:flutter/material.dart';

import '../api/mutations.dart';

class AddBookDialog extends StatefulWidget {
  const AddBookDialog({Key? key}) : super(key: key);

  @override
  State<AddBookDialog> createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  late String textFieldVal;

  Future<void> handleSubmit(BuildContext context, String url) async {
    debugPrint(textFieldVal);
    await addBook(textFieldVal)
        .whenComplete(() => (){
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Book'),
      content: SingleChildScrollView(
        child: TextField(
          onChanged: (val){
            textFieldVal = val;
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            handleSubmit(context, textFieldVal);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
