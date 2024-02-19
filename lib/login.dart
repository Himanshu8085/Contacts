import 'package:flutter/material.dart';
import 'Dashboard.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  bool _showOTP = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Enter Mobile Number',
              ),
            ),
            SizedBox(height: 20),
            if (_showOTP)
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_showOTP) {
                  // Validate OTP
                  if (_otpController.text == '1234') {
                    // Navigate to next screen or perform login
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login Successful!')),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard()),
                    );
                  } else {
                    // Show error message or handle invalid OTP
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invalid OTP')),
                    );
                  }
                } else {
                  // Show OTP input field
                  setState(() {
                    _showOTP = true;
                  });
                }
              },
              child: Text(_showOTP ? 'Enter' : 'Get OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
