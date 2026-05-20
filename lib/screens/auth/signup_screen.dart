import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_flutter/providers/auth/auth_provider.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passConController = TextEditingController();
  bool isGoogleSignin = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passConController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "Signup",
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

                TextField(
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  obscureText: true,
                  controller: passConController,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                  ),
                ),

                SizedBox(height: 15),

                ElevatedButton(
                  onPressed: authState.isLoading
                      ? null
                      : () {
                          String email = emailController.text.trim();
                          String password = passwordController.text.trim();
                          String conPassword = passConController.text.trim();

                          if (email.isEmpty || password.isEmpty) return;
                          if (password != conPassword) return;

                          ref
                              .watch(authProvider.notifier)
                              .signup(email, password);
                        },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 56),
                    backgroundColor: Color(0xFF173200),
                  ),
                  child: Text("Signup", style: TextStyle(color: Colors.white)),
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
                      : () {
                          ref.watch(authProvider.notifier).googleSignIn();
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
                    Text("Already have an account?"),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
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
