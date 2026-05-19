import 'package:flutter/material.dart';
import 'package:noted_flutter/services/auth_services.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                SizedBox(height: 100),
                      Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
            
                      SizedBox(height: 25),
            
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your Email",
                          enabledBorder: borderStyle,
                          focusedBorder: borderStyle
                        ),
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          final emailText = emailController.text.trim();
                          if (emailText.isEmpty) return;

                          AuthServices().forgotPassword(emailText);

                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 56),
                          backgroundColor: Color(0xFF173200),
                        ),
                        child: Text("Send Link", style: TextStyle(color: Colors.white)),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final borderStyle = OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xFF173200), width: 2),
                    );