import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_reader/api/mutations.dart';
import 'package:royal_reader/addBook/add_book_dialog.dart';
import 'package:royal_reader/booksList/book.dart';
import 'package:sizer/sizer.dart';

import 'book_list_item.dart';
import '../api/queries.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key, required this.title});

  final String title;

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  late Future<List<Book>> books;

  @override
  void initState() {
    super.initState();
    books = fetchBooks();
  }

  void handleBookPressed(int id, String name){
    debugPrint('$id pressed');
    context.push(Uri(path: '/book/$id', queryParameters: {'name': name}).toString());
  }

  Future<void> refreshBooks() async {
    setState(() {
      books = fetchBooks();
    });
  }

  Future<void> _showAddBookDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const AddBookDialog();
      },
    );
  }

  Future<void> _showDeleteBookDialog(int id) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return deleteBookDialog(id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                _showAddBookDialog();
              },
              icon: Icon(
                  Icons.add,
                size: 3.h,
              )
          ),
        ],
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () => refreshBooks(),
          child: FutureBuilder(
            future: books, // your async method that returns a future
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // if data is null
                if (snapshot.data.length == 0) {
                  return Stack(
                    children: [
                      const Center(
                        child: Text(
                          'No books found',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [],
                      )
                    ]
                  );
                }

                // if data is loaded
                return ListView.builder(
                  padding: EdgeInsets.all(4.w),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Center(
                      child: BookListItem(
                        book: snapshot.data[i],
                        handleBookPressed: handleBookPressed,
                        handleDeleteDialog: _showDeleteBookDialog,
                      ),
                    );
                  },
                ).build(context);
              } else if (snapshot.hasError) {
                return Stack(
                  children: [
                    Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [],
                    )
                  ]
                );
              }else {
                // if data not loaded yet
                return const CircularProgressIndicator();
              }
            },
          ),
        )
      ),
    );
  }

  Widget deleteBookDialog(int id) {
    return AlertDialog(
      title: const Text('Delete Book'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('Are you sure you want to delete this book?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Yes'),
          onPressed: () async {
            await deleteBook(id.toString());
            refreshBooks();
            context.pop();
          },
        ),
        TextButton(
          child: const Text('No'),
          onPressed: () {
            context.pop();
          },
        ),
      ],
    );
  }
}
