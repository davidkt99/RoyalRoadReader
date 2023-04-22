import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_reader/booksList/books_list_page.dart';
import 'package:royal_reader/chapterContent/chapter_content_page.dart';
import 'package:royal_reader/chaptersList/chapters_list_page.dart';
import 'package:sizer/sizer.dart';


void main() {
  runApp(const MyApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const BooksPage(title: 'Books');
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'book/:id',
          name: "book",
          builder: (BuildContext context, GoRouterState state) {
            return ChaptersPage(id: int.parse(state.params['id']!), bookName: state.queryParams['name']!);
          },
        ),
        GoRoute(
          path: 'chapter/:id',
          name: "chapter",
          builder: (BuildContext context, GoRouterState state) {
            return ChapterContentPage(id: int.parse(state.params['id']!), chapters: state.extra as List,);
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routerConfig: _router,
        );
      }
    );
  }
}