import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_news_app/repository/routes/routes_name.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),(){

      Navigator.pushNamed(context, RouteName.homeScreen);
    });

  }

  @override
  Widget build(BuildContext context) {
    final _height= MediaQuery.sizeOf(context) .height * 1;
    final _width= MediaQuery.sizeOf(context) .width * 1;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/splash_pic.jpg',
            fit: BoxFit.cover,
              height: _height * .5,
            ),
            SizedBox(height: _height * 0.04,),
            Text('TOP HEADLINES',style: GoogleFonts.anton(letterSpacing: .6,color: Colors.grey.shade700),),
            SizedBox(height: _height * 0.04,),
            SpinKitChasingDots(
              size: 40,
              color: Colors.blue,
            )

          ],
        ),
      ),

    );
  }
}
