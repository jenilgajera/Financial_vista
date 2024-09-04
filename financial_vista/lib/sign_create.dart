import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image of hands holding a phone
            Image.asset(
              'assets/images/hand_hold_phone.png', // Correct path to the image
              height: 300,
            ),
            const SizedBox(height: 40),
            
            // Sign In Button
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  // Sign In action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Background color
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Create Account Button
            SizedBox(
              width: 300,
              child: OutlinedButton(
                onPressed: () {
                  // Create Account action
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black), // Border color
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
        ),
      ),
    );
  }
}
