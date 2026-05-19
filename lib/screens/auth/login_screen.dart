import 'package:flutter/material.dart';
import 'package:noted_flutter/screens/auth/forgot_password_screen.dart';
import 'package:noted_flutter/screens/auth/signup_screen.dart';
import 'package:noted_flutter/services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final auth = AuthServices();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                SizedBox(height: 100),
                Text(
                  "Login",
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
                    hintText: "Email",
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                  ),
                ),

                SizedBox(height: 15),

                TextField(
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) return;

                    auth.userLogin(email, password);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 56),
                    backgroundColor: Color(0xFF173200),
                  ),
                  child: Text("Login", style: TextStyle(color: Colors.white)),
                ),

                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 1,
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                    SizedBox(width: 10),
                    Text("OR"),
                    SizedBox(width: 10),
                    Container(
                      width: 80,
                      height: 1,
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    auth.googleSignin();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 56),
                    elevation: 0,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/google.png', height: 24),
                      SizedBox(width: 15),
                      Text(
                        "Continue with Google",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(
                          color: Color(0xFF173200),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
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
