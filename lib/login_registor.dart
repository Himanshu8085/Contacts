import 'package:contacts_manager_v1_task_2/login.dart';
import 'package:contacts_manager_v1_task_2/register.dart';
import 'package:flutter/material.dart';

// Himanshu kothekar project
class LR extends StatefulWidget {
  const LR({super.key});

  @override
  State<LR> createState() => _LRState();
}

class _LRState extends State<LR> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Login & Registrition"),
            backgroundColor: Colors.blue,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                LoginButton(
                  context: context,
                ),
                SizedBox(height: 50),
                RegisterButton(
                  context: context,
                )
              ],
            ),
          )),
    );
  }
}

// Login Button
class LoginButton extends StatelessWidget {
  final BuildContext context;
  LoginButton({required this.context});
  void _onButtonPressed() {
    print('login');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onButtonPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Set background color to blue
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'Login',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}

// Registor button
class RegisterButton extends StatelessWidget {
  final BuildContext context;
  RegisterButton({required this.context});
  void _onButtonPressed() {
    print('register');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onButtonPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Set background color to blue
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'Register',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
