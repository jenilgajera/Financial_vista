import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.yellow,
                    child: Text(
                      "🦁",
                      style: TextStyle(fontSize: 60),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        // Add profile picture update logic here
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Name Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Krupansu Sorathiya',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Email Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'krupansusorathiya@gmail.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Phone Number Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '+91 1234567890',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Date of Birth Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  hintText: '23/05/1995',
                  suffixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Country/Region Input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Country/Region',
                  hintText: 'India',
                  suffixIcon: Image.asset(
                    'assets/image/flag.png', // Add your flag image asset here
                    width: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Save Changes Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add save changes logic here
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFF6F35A5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Save changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
