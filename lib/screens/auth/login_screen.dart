import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_flutter/providers/auth/auth_provider.dart';
import 'package:noted_flutter/screens/auth/forgot_password_screen.dart';
import 'package:noted_flutter/screens/auth/signup_screen.dart';
import 'package:noted_flutter/screens/main/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isGoogleSignin = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Login Successful"),
                backgroundColor: Color(0xFF173200),
                behavior: SnackBarBehavior.floating,
              ),
            );

            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
            );
          }
        },

        error: (err, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(err.toString()),
              backgroundColor: Colors.red.shade300,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      );
    });

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
                    Navigator.pushReplacement(
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
                  onPressed: authState.isLoading
                      ? null
                      : () {
                          String email = emailController.text.trim();
                          String password = passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) return;

                          ref
                              .read(authProvider.notifier)
                              .login(email, password);
                        },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 56),
                    backgroundColor: Color(0xFF173200),
                  ),
                  child: authState.isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text("Login", style: TextStyle(color: Colors.white)),
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
                  onPressed: isGoogleSignin
                      ? null
                      : () async {
                          setState(() {
                            isGoogleSignin = true;
                          });
                          try {
                            await ref
                                .read(authProvider.notifier)
                                .googleSignIn();
                          } finally {
                            if (mounted) {
                              setState(() {
                                isGoogleSignin = false;
                              });
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 56),
                    elevation: 0,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  child: isGoogleSignin
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Row(
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
                        Navigator.pushReplacement(
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
