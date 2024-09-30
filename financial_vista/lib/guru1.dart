import 'package:flutter/material.dart';

class ConsultGuruPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: Text('Consult a Guru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            // Profile Image and Info
            Container(
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/nenis.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nenis Rudani',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text('Personal Finance & Investment Advisor'),
                  SizedBox(height: 4),
                  Text('🇮🇳', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Question Input
            TextField(
              decoration: InputDecoration(
                labelText: 'Ask your questions?',
                suffixIcon: Icon(Icons.document_scanner_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Email Address Input
            TextField(
              decoration: InputDecoration(
                labelText: 'Email address',
                hintText: 'helloworld@gmail.com',
                suffixIcon: Icon(Icons.check_circle, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Phone Number Input
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone number',
                hintText: '+91 1234567890',
                suffixIcon: Icon(Icons.check_circle, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                // Implement form submission or navigation
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // Button background color
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              ),
              child: Text(
                'Consult a Guru',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
