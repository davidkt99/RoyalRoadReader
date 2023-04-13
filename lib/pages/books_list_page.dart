import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_reader/types/book.dart';
import 'package:sizer/sizer.dart';

import '../components/book_list_item.dart';
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () => refreshBooks(),
          child: FutureBuilder(
            future: books, // your async method that returns a future
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // if data is loaded
                return ListView.builder(
                  padding: EdgeInsets.all(4.w),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Center(
                      child: BookListItem(
                        id: snapshot.data[i].id,
                        name: snapshot.data[i].name,
                        handleBookPressed: handleBookPressed,
                        numOfChap: snapshot.data[i].numOfChap,
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
}
