import 'package:flutter/material.dart';
import 'package:task_todo/db.dart';
import 'Extension.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isValidEmail = true, isValidPassword = true , isVaildName=true , isObsecure = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void validateEmail() {
    setState(() {
      isValidEmail = _emailController.text.isValidEmail();
    });
  }
  void validateName() {
    setState(() {
      isVaildName = _nameController.text.isValidName();
    });
  }

  void validatePassword() {
    setState(() {
      isValidPassword = _passwordController.text.isValidPassword();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight, // Ensure the Stack takes full height
          ),
          child: IntrinsicHeight(
            child: Stack(
              children: [
                Positioned(
                  left: -5,
                  top: 5,
                  child: Image(image: AssetImage('assets/images/img2.png')),
                ),
                Positioned(
                  top: 165,
                  right: 40,
                  child: Text(
                    'Get\nStarted!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  top: 240,
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
                              'Sign Up',
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
                  top: 294,
                  left: 40,
                  right: 40,
                  child: TextField(
                    onChanged: (newText) {
                      validateEmail();
                    },
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      suffix: isVaildName
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
                  top: 368,
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
                  top: 443,
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
                  left: 20,
                  right: 20,
                  bottom: 250,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Yes, I agree to the'),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          child: Text(
                            ' Terms & Services.',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                                color: Colors.indigo),
                          ),
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 580,
                  left: 20,
                  right: 20,
                  child: InkWell(
                    onTap: () {
                      String email = _emailController.text;
                      if (isValidEmail && isValidPassword) {
                        if(users.containsKey(email)){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Email is already exist!'))
                          );
                        }
                        else{
                          users[_emailController.text] = _passwordController.text;
                          Navigator.pushReplacementNamed(context, '/home');
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
                  top: 600,
                  left: 20,
                  right: 20,
                  bottom: 24,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Existing User?'),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          child: Text(
                            'Log In',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.indigo),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
