import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 53, 68, 155),
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
        child: Stack(
          children: [
            Center(child: Image(image: AssetImage('assets/images/img1.png')),),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Text('Welcome' , style: TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.bold),)
              ),
            )
          ],
        ),
      ),
    );
  }
}