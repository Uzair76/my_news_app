
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_news_app/repository/routes/routes_name.dart';
import 'package:my_news_app/view/home_screen.dart';
import 'package:my_news_app/view/splash_screen.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {

      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (_) =>  HomeScreen());


    //Statement to show as default route
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
