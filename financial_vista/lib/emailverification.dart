import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:financial_vista/passowrd_reset.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;

  const EmailVerificationScreen({super.key, required this.email});

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  late Timer _timer;
  int _start = 30; // Countdown for OTP resend
  final TextEditingController _otpController = TextEditingController();
  String? _verificationId; // Store the verification ID

  @override
  void initState() {
    super.initState();
    _startTimer();
    _sendVerificationOTP();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  Future<void> _sendVerificationOTP() async {
    setState(() {
      isLoading = true;
    });

    try {
      // This is where you'd send the OTP to the user's email
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification OTP sent to your email!')),
      );

      // Simulate getting a verification ID (actual implementation will depend on OTP provider)
      _verificationId = "123456"; // Replace this with actual OTP logic

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending OTP: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _verifyOTP() async {
    setState(() {
      isLoading = true;
    });

    if (_otpController.text.trim() == _verificationId) {
      // OTP verified successfully
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PasswordResetScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _otpController.dispose(); // Dispose of the OTP controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 50),
            const Text(
              'Verify Your Email',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "We've sent a verification OTP to ${widget.email}. Please enter the OTP below.",
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(
                labelText: 'OTP',
                hintText: 'Enter the OTP sent to your email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _verifyOTP,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xff77f50cc),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Verify OTP',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: _start == 0 ? _resendVerificationEmail : null,
                  child: const Text(
                    'Resend OTP',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '00:${_start.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _resendVerificationEmail() async {
    // Resend the verification email/OTP
    setState(() {
      _start = 30; // Reset the timer
    });
    _startTimer();
    _sendVerificationOTP(); // Call the function to send the OTP
  }
}
