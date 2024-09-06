import 'package:financial_vista/auth/create_account.dart';
import 'package:financial_vista/signing.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Determine the image height based on screen width
            double imageHeight = constraints.maxWidth * 1.3;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image of hands holding a phone
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Image.asset(
                    "assets/image/hand_phone.jpg",
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: imageHeight,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 40),

                // Sign In Button
                SizedBox(
                  width: constraints.maxWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sign In button pressed')),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                          0xFF7F50CC,), // Correct color code with the 0xFF prefix
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Create Account Button
                SizedBox(
                  width: constraints.maxWidth * 0.8,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAccountScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Create account',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
