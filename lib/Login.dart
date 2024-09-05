import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Stack(
        children: [
          Positioned(
            right: -90,
            top: 5,
            child: Image(image: AssetImage('assets/images/img1.png'))
            ),
          Positioned(
              top: 200,
              left: 10,
              child: Text('Welcome\nBack!',style: TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.bold),),)
         ,
         Positioned(
            top: 280,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            child: Column(children: [
              Center(child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text('Login' ,style: TextStyle(color: Colors.indigo , fontSize: 30 ),),
              ),)
            ],),
          ))
        ,
        
        ],
      ),
    );
  }
}