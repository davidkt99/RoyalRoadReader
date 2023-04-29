import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'booksListPage/books_list_page.dart';
import 'chapterContentPage/chapter_content_page.dart';
import 'chaptersListPage/chapters_list_page.dart';
import 'loginPage/loginPage.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'books',
          name: "booksList",
          builder: (BuildContext context, GoRouterState state) {
            return const BooksPage(title: 'Books');
          },
        ),
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