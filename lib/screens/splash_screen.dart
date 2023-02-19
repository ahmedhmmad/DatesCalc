import 'dart:async';

import 'package:datescalculator/screens/datedifference.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DateDifferenceApp())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.date_range,
            size: 150,
            color: Colors.yellow[900],
          ),
          const SizedBox(
            height: 10,
          ),
          const CircularProgressIndicator(),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'مديرية التربية والتعليم-رفح',
            style: TextStyle(
                fontFamily: 'Cairo', fontSize: 22, fontWeight: FontWeight.w500),
          ),
          const Text(
            'قسم الشئون الادارية',
            style: TextStyle(
                fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ]),
      ),
    );
  }
}
