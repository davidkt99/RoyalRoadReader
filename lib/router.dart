import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'booksList/books_list_page.dart';
import 'chapterContent/chapter_content_page.dart';
import 'chaptersList/chapters_list_page.dart';

/// The route configuration.
final GoRouter router = GoRouter(
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