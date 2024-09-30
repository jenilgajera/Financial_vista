import 'package:flutter/material.dart';

class Guru2 extends StatelessWidget {
  const Guru2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meet our Financial Gurus'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.purple[50], // Light purple background
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // First Guru Container
              buildGuruContainer(
                context: context,
                imageUrl: 'assets/image/krupansu.png', // Local image
                name: 'Krupansu sorathiya',
                title: 'Tax and Debt management consultant',
              ),
              const SizedBox(height: 16),

              // Form UI
              buildFormContainer(context),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build each Guru Container
  Widget buildGuruContainer({
    required BuildContext context,
    required String imageUrl,
    required String name,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Full Width Image at the Top
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: Image.asset(
              imageUrl,
              width: double.infinity, // Full width image
              height: 400, // Fixed height for the image
              fit: BoxFit.cover, // Make sure the image covers the entire area
            ),
          ),

          // Text area with background color or gradient
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF6EEFF), // Light purple background
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Guru Name
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),

                // Guru Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Form UI
  Widget buildFormContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Ask your questions?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Notes TextField
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Notes',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.copy),
            ),
          ),
          const SizedBox(height: 20),

          // Email Input
          TextField(
            decoration: InputDecoration(
              labelText: 'Email address',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.check_circle, color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),

          // Phone Input
          TextField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone number',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.check_circle, color: Colors.black),
            ),
          ),
          const SizedBox(height: 30),

          // Submit Button
          ElevatedButton(
            onPressed: () {
              // Handle form submission logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple, // Button background color
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Consult a Guru',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
