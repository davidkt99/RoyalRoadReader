import 'package:flutter/material.dart';
import 'package:royal_reader/types/book.dart';

import '../components/book_list_item.dart';
import '../api/queries.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key, required this.title});

  final String title;

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  List<Book> books = [];

  void handleFetchBooks() async{
    books = await fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    /// Fetches Books
    handleFetchBooks();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchBooks(), // your async method that returns a future
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // if data is loaded
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemExtent: 20.0,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int i) {
                  return Center(
                    child: Text(
                      snapshot.data[i].name,
                      style: const TextStyle(color: Colors.black, fontSize: 17.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ).build(context);
            } else {
              // if data not loaded yet
              return const CircularProgressIndicator();
            }
          },
        )
      ),
    );
  }
}
