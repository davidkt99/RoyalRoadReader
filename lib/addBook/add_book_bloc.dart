import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/mutations.dart';

// Notifies bloc to handle addBook mutation
class AddBookEvent {
  final String url;

  const AddBookEvent({required this.url});
}

abstract class AddBookState {}
class AddBookInitialState extends AddBookState {}
class AddBookLoadingState extends AddBookState {}
class AddBookSuccessState extends AddBookState {
  final bool addBookSuc;
  AddBookSuccessState({required this.addBookSuc});
}
class AddBookErrorState extends AddBookState {
  final String errorMessage;
  AddBookErrorState({required this.errorMessage});
}



class AddBookBloc extends Bloc<AddBookEvent, AddBookState> {
  AddBookBloc() : super(AddBookInitialState()) {
    on<AddBookEvent>((event, emit) async {
      emit(AddBookLoadingState());
      try {
        final suc = await addBook(event.url);
        emit(AddBookSuccessState(addBookSuc: suc));
      } catch (e) {
        emit(AddBookErrorState(errorMessage: e.toString()));
      }
    });
  }
}