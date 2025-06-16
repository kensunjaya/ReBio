import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rebio/components/CustomButton.dart';
import 'package:rebio/components/CustomTextField.dart';
import 'package:rebio/theme/constants.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  bool _acceptTerms = false;
  bool _obscurePassword = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty || usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }
    // Terms & Privacy Policy Validation
    if (!_acceptTerms){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must accept the Terms & Privacy Policy"))
      );
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await _firestore.collection('users').doc(emailController.text.trim()).set({
        'profile': {
          'email': emailController.text.trim(),
          'username': usernameController.text.trim(),
        },
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully')),
      );

      Navigator.pop(context); // Go back to login
    } on FirebaseAuthException catch (e) {
      String error = switch (e.code) {
        'email-already-in-use' => 'The email is already in use.',
        'invalid-email' => 'Invalid email address.',
        'weak-password' => 'Password is too weak.',
        _ => 'Something went wrong. Try again.',
      };

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Register')),
      backgroundColor: bg,
      body: Center(
        child:SingleChildScrollView(
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
                  // Register Tittle
                  Text(
                    "Create Account",
                    style: GoogleFonts.notoSans(color: Colors.black, fontSize: 28, fontWeight: FontWeight.w800),
                  ),
                  // Username Box
                  const SizedBox(height: 20),
                  CustomTextInput(
                    controller: usernameController,
                    label: 'Username',
                    hintText: 'Your Username',                    
                  ),
                  // Email Box
                  const SizedBox(height: 16),
                  CustomTextInput(
                    controller: emailController,
                    label: 'Email',
                    hintText: 'Your Email',                    
                  ),
                   // Password Box
                  const SizedBox(height: 16),
                  CustomTextInput(
                    controller: passwordController,
                    isPassword: true,
                    label: 'Password',
                    hintText: 'must be 8 characters',
                    obscureText: _obscurePassword,
                    onToggleVisibility: (){
                      setState((){
                      _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  // Accept terms box
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        onChanged: (value){
                          setState(() {
                            _acceptTerms = value ?? false;
                          });
                        },
                        fillColor: WidgetStateProperty.all(secondary),
                        side: BorderSide(color: secondary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        
                        checkColor: Colors.white,
                      ),
                      const Expanded(
                        child: Text("I accept the terms and privacy policy"),
                      ),
                    ],
                  ),
                  // Register Button
                  const SizedBox(height: 24),
                  CustomButton(
                    text: "Create Account",
                    onPressed: () => registerUser(context),
                    verticalPadding: 16,
                    backgroundColor: secondary,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text('Or Register with'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/google_logo.png',
                          height: 16,                    
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Icon(Icons.facebook, color: Colors.blue),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Icon(Icons.apple),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?", style: GoogleFonts.notoSans(color: Colors.black, fontSize: 14)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          "Log in",
                          style: GoogleFonts.notoSans(color: primary, fontSize: 14, fontWeight: FontWeight.w600, decoration: TextDecoration.underline)
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ), 
          ),
        ),
      ),
    );
  }
}
