import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rebio/auth.dart'; // Replace with your actual auth path
import 'package:rebio/components/CustomButton.dart';
import 'package:rebio/components/CustomTextField.dart';
import 'package:rebio/theme/constants.dart';
import 'register.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      // CustomToast(context).showToast('Please fill in all required fields!', Icons.error_rounded);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all required fields!')),
      );
      return;
    }

    try {
      await Auth().signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // CustomToast(context).showToast('Logged in successfully!', Icons.check_rounded);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful!')),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      String errorMessage = switch (e.code) {
        'invalid-email' => 'The email address is not valid.',
        'user-disabled' => 'Your account has been disabled.',
        'user-not-found' => 'No user found with this email.',
        'wrong-password' => 'Incorrect password.',
        _ => 'Login failed. Please try again.',
      };
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      // CustomToast(context).showToast(errorMessage, Icons.error_rounded);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occured.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Login')),
      backgroundColor: Color(0xFFF1F5F9),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                )
              ]
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Login',
                    style: GoogleFonts.notoSans(color: Colors.black, fontSize: 28, fontWeight: FontWeight.w800),
                  ),
                  // Username Box
                  const SizedBox(height: 24),
                  CustomTextInput(label: "Email", hintText: "Your email address", controller: emailController),
                  
                  //Password Box
                  const SizedBox(height: 16),
                  CustomTextInput(label: "Password", hintText: "must be 8 characters", controller: passwordController, isPassword: true),
                  // Forgot Password
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Forgot password?', style: TextStyle(color: Colors.black)),
                    ),
                  ),

                  //Login Button
                  const SizedBox(height: 24),
                  CustomButton(
                    text: "Log in", 
                    onPressed: () => login(context),
                    verticalPadding: 18,
                    backgroundColor: secondary,
                  ),

                  //Other option to log in
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text('Or log in with'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child: Image.asset(
                          'assets/images/google_logo.png',
                          height: 24,                    
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: Icon(Icons.facebook, color: Colors.blue),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: Icon(Icons.apple),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: GoogleFonts.notoSans(color: Colors.black, fontSize: 14)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()),
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: GoogleFonts.notoSans(color: primary, fontSize: 14, fontWeight: FontWeight.w600, decoration: TextDecoration.underline)
                        ),
                      ),
                    ],
                  )
                  
                ],
              )
            )
          )
        )
        ,
      ),
    );
  }
}
