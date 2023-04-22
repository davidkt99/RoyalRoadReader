import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royal_reader/addBook/add_book_bloc.dart';

import '../api/mutations.dart';

class AddBookDialog extends StatefulWidget {
  const AddBookDialog({Key? key}) : super(key: key);

  @override
  State<AddBookDialog> createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  late String textFieldVal;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddBookBloc(),
      child: BlocBuilder<AddBookBloc, AddBookState>(
        builder: (context, state) {
          if(state is AddBookInitialState){
            return AlertDialog(
              title: const Text('Add Book'),
              content: SingleChildScrollView(
                child: TextField(
                  onChanged: (val) {
                    textFieldVal = val;
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    final bloc = BlocProvider.of<AddBookBloc>(context);
                    bloc.add(AddBookEvent(url: textFieldVal));
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          }
          if(state is AddBookLoadingState){
            return const AlertDialog(
              title: Text('This may take sometime'),
              content: SingleChildScrollView(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          if (state is AddBookErrorState) {
            return AlertDialog(
              title: const Text('Add Book'),
              content: SingleChildScrollView(
                child: Center(
                  child: Text(
                    state.errorMessage,
                  ),
                ),
              ),
            );
          }
          if (state is AddBookSuccessState) {
            return const AlertDialog(
              title: Text('Add Book'),
              content: SingleChildScrollView(
                child: Center(
                  child: Text(
                    "Book Successfully Added!",
                  ),
                ),
              ),
            );
          }

          return Container();
        }),
    );
  }
}
