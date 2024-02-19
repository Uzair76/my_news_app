import 'package:flutter/material.dart';
import 'package:my_news_app/repository/routes/routes.dart';
import 'package:my_news_app/repository/routes/routes_name.dart';
import 'package:my_news_app/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),

      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,

    );
  }
}
