
import 'package:flutter/material.dart';
import 'package:royal_reader/router.dart';
import 'package:royal_reader/styles.dart';
import 'package:sizer/sizer.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(false, context),
          darkTheme: Styles.themeData(true, context),
          routerConfig: router,
        );
      }
    );
  }
}