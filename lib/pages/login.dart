import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rebio/auth.dart'; // Replace with your actual auth path
import 'register.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      // CustomToast(context).showToast('Please fill in all required fields!', Icons.error_rounded);
      return;
    }

    try {
      await Auth().signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // CustomToast(context).showToast('Logged in successfully!', Icons.check_rounded);
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      String errorMessage = switch (e.code) {
        'invalid-email' => 'The email address is not valid.',
        'user-disabled' => 'Your account has been disabled.',
        'user-not-found' => 'No user found with this email.',
        'wrong-password' => 'Incorrect password.',
        _ => 'Login failed. Please try again.',
      };
      // CustomToast(context).showToast(errorMessage, Icons.error_rounded);
    } catch (e) {
      // CustomToast(context).showToast('An unexpected error occurred.', Icons.error_rounded);
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
              ),
              // Username Box
              const SizedBox(height: 24),
              TextFormField(
                //controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Username/Email',
                  hintText: 'Please input your username or email',
                  border: OutlineInputBorder(),
                ),
              ),
              
              //Password Box
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'must be 8 characters',
                  border: OutlineInputBorder(),
                ),
              ),
              // Forgot Password
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text('Forgot password?',
                  style: TextStyle(color: Colors.black),
                  ),
                ),
              ),

              //Login Button
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => login(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF10493F),
                    padding: const EdgeInsets.symmetric(vertical: 24),
                  ),
                  child: const Text(
                    'Log in',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    ),                  
                ),
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
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          )
        )
        ,
      ),
    );
  }
}
