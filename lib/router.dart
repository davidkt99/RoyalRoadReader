import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_reader/weeklyChaptersList/updatesListPage.dart';

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
          path: 'chapter/:loc',
          name: "chapter",
          builder: (BuildContext context, GoRouterState state) {
            return ChapterContentPage(loc: int.parse(state.params['loc']!), chapters: state.extra as List,);
          },
        ),
        GoRoute(
          path: 'updates',
          name: "updates",
          builder: (BuildContext context, GoRouterState state) {
            return const UpdatesListPage();
          },
          routes: [
            GoRoute(
                path: 'update/:loc',
                name: 'update',
              builder: (BuildContext context, GoRouterState state) {
                return ChapterContentPage(loc: int.parse(state.params['loc']!),chapters: state.extra as List, nextButtonsEnabled: false,);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);