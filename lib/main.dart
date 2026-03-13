import 'package:flutter/material.dart';
import 'splash_screen.dart';
void main(){
  runApp(covid_19());
}

class covid_19 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}