import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'db.dart';
import 'Extension.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isValidEmail = true, isValidPassword = true,isObsecure = true  ;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void validateEmail() {
    setState(() {
      isValidEmail = _emailController.text.isValidEmail();
    });
  }

  void validatePassword() {
    setState(() {
      isValidPassword = _passwordController.text.isValidPassword();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the height of the screen
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight, // Make sure the Stack takes full height
          ),
          child: IntrinsicHeight(
            child: Stack(
              children: [
                const Positioned(
                  right: -90,
                  top: 5,
                  child: Image(image: AssetImage('assets/images/img1.png')),
                ),
                const Positioned(
                  top: 168,
                  left: 30,
                  child: Text(
                    'Welcome\nBack!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  top: 245,
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
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.indigo, fontSize: 30),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 308,
                  left: 40,
                  right: 40,
                  child: TextField(
                    onChanged: (newText) {
                      validateEmail();
                    },
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: isValidEmail ? null : 'Email is not valid',
                      suffix: isValidEmail
                          ? Image(
                              image: AssetImage('assets/icons/check.png'),
                              width: 15,
                              height: 15,
                            )
                          : Image(
                              image: AssetImage('assets/icons/close.png'),
                              width: 15,
                              height: 15,
                            ),
                    ),
                  ),
                ),
                Positioned(
                  top: 390,
                  left: 40,
                  right: 40,
                  child: TextField(
                    onChanged: (newText) {
                      validatePassword();
                    },
                    obscuringCharacter: '·',
                    obscureText: isObsecure,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: isValidPassword
                            ? null
                            : 'Password must be at least 8 characters\n1 special character and 1 capital letter',
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isObsecure = !isObsecure; // Toggle password visibility
                                });
                              },
                              child: ImageIcon(
                                size: 20,
                                isObsecure
                                    ? AssetImage('assets/icons/view.png' )
                                    : AssetImage('assets/icons/hide.png'),
                              ),
                            ),
                            SizedBox(width: 8,),
                            isValidPassword
                                ? Image(
                              image: AssetImage('assets/icons/check.png'),
                              width: 15,
                              height: 15,
                            )
                                : Image(
                              image: AssetImage('assets/icons/close.png'),
                              width: 15,
                              height: 15,
                            ),
                          ],
                        )
                    ),
                  ),
                ),
                Positioned(
                  top: 500,
                  left: 20,
                  right: 20,
                  child: InkWell(
                    onTap: () {
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      if (isValidEmail && isValidPassword) {
                        if (users.containsKey(email)) {
                          if (users[email] == password) {
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Incorrect Password!')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Email Not Found!')));
                        }
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 106, 27, 154),
                            Color.fromARGB(255, 36, 92, 170)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'PROCEED',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 35,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Newbie?'),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.indigo),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
