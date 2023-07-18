import 'dart:async';

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Image(
            image: AssetImage(
              'assets/images/bg.jpg',
            ),
            height: 300,
            width: 280,
          ),
          const CircularProgressIndicator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(width: 20),
              Text(
                "Bhagavad Geeta",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
