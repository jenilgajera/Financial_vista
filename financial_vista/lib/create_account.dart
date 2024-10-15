import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _isPasswordVisible = false;
  bool _isChecked = false;

  // Controllers for TextFields
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseFirestore db = FirebaseFirestore.instance; // Firestore instance

  // Function to get the next unique user id (u_id)
  Future<int> _getNextUniqueUserId() async {
    DocumentReference counterRef =
        db.collection('counters').doc('usersCounter');

    // Run a transaction to safely increment and verify the unique u_id
    return await db.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(counterRef);

      if (!snapshot.exists) {
        // Initialize the counter if it doesn't exist
        transaction.set(counterRef, {'u_id': 1});
        return 1;
      }

      int currentId = snapshot['u_id'];
      int newId = currentId + 1;

      // Ensure that the new u_id is unique
      while (await _checkUserIdExists(newId)) {
        newId++; // Increment until we find an available u_id
      }

      // Update the counter with the new u_id
      transaction.update(counterRef, {'u_id': newId});

      return newId;
    });
  }

  // Function to check if a given u_id already exists in Firestore
  Future<bool> _checkUserIdExists(int uId) async {
    QuerySnapshot userQuery = await db
        .collection('users')
        .where('u_id', isEqualTo: uId)
        .limit(1)
        .get();

    return userQuery.docs.isNotEmpty;
  }

  // Function to check if the email is already registered
  Future<bool> _checkEmailExists(String email) async {
    QuerySnapshot emailQuery = await db
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return emailQuery.docs.isNotEmpty;
  }

  // Function to store data in Firestore
  void _createAccount() async {
    if (usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        _isChecked) {
      // Check if email already exists
      bool emailExists = await _checkEmailExists(emailController.text);
      if (emailExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text("Email already exists. Please use a different email."),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Get the next unique u_id
      int userId = await _getNextUniqueUserId();

      // Add data to Firestore with the unique u_id
      await db.collection('users').add({
        'u_id': userId, // Unique u_id
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text, // You might want to hash this
        'createdAt': Timestamp.now(), // Add a timestamp
      });

      // Clear the form
      usernameController.clear();
      emailController.clear();
      passwordController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account Created Successfully!"),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back to SignInScreen after creation
      Navigator.pop(context);
    } else {
      // Show error if fields are not filled or terms not accepted
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields and accept the terms."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate image height based on screen width
    double imageHeight = MediaQuery.of(context).size.width * 0.6;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Adjust based on the top margin

              Center(
                child: Image.asset(
                  "assets/image/create_Acc.png",
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Create account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  const Text('I accept the terms and privacy policy'),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 360, // Set the desired width here
                  child: ElevatedButton(
                    onPressed:
                        _createAccount, // Call function to create account
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      backgroundColor:
                          const Color(0xff77f50cc), // Purple background
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                    ),
                    child: const Text(
                      'Create account',
                      style: TextStyle(
                        color: Colors.white, // Set font color to white
                        fontSize: 18, // Font size
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigate back to SignInScreen
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Already have an account? Sign in',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
