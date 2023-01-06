import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kelasmbl/LoginPage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState(){
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (content) => const LoginPage()))
    );

  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 0, 20),
          child : Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const[
              Text(
                 "HomeStay Raya",
                style: TextStyle(
                    
                    fontSize: 48,
                    fontWeight: FontWeight.bold),
              ),
              CircularProgressIndicator(),
              
            ],
          )
        )
      ],
    );


  }
}
  