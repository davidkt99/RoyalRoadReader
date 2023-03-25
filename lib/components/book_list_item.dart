import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => {
        debugPrint('$id pressed')
        },
        child: Container(),
      ),
    );
  }
}
