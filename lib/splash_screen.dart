import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    controller.repeat();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RotationTransition(
              turns: animation,
                child: Image.asset(
                  'assets/images/virus_image.png',
                  width: 300,
                  height: 300,
                ),
              ),
            ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text('Covid-19\nTracker App',
              textAlign: TextAlign.center,
              style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),),
          )
        ],
      ),
    );
  }
}
