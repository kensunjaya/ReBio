import 'package:flutter/material.dart';
import 'package:rebio/components/CustomButton.dart';
import 'package:rebio/theme/constants.dart';
import 'register.dart';
import 'login.dart';
import 'package:google_fonts/google_fonts.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/rebiologo.png', height: 200, width: 200),
              const SizedBox(height: 20),
              Text(
                'ReBio',
                style: TextStyle(
                  fontFamily: GoogleFonts.baloo2().fontFamily,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),
              const SizedBox(height: 50),
              CustomButton(
                      text: "Log in", 
                      onPressed: () => Navigator.pushReplacement(
                      context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                    ),
                      disabled: isLoading,
                      verticalPadding: 18,
                      backgroundColor: primary,
                    ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Register',
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                ),
                disabled: isLoading,
                verticalPadding: 18,
                backgroundColor: secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}