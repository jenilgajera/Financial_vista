import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial Gurus',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const FinancialGurusScreen(),
    );
  }
}

class FinancialGurusScreen extends StatelessWidget {
  const FinancialGurusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meet our Financial Guru'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Welcome to the Financial Gurus section. Our team of experts is here to provide you with guidance on all your financial needs.",
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  financialGuruCard(
                    imageUrl: 'assets/nenis_rudani.png',
                    name: 'Nenis Rudani',
                    title: 'Investment Specialist',
                    description:
                        'Nenis is a finance expert with years of experience in investment planning and wealth management. He is committed to helping you grow your assets.',
                  ),
                  financialGuruCard(
                    imageUrl: 'assets/krupansu_sorathiya.png',
                    name: 'Krupansu Sorathiya',
                    title: 'Tax Consultant',
                    description:
                        'Krupansu has a deep understanding of tax laws and will guide you in minimizing your tax liability while staying compliant with regulations.',
                  ),
                  financialGuruCard(
                    imageUrl: 'assets/jenil_gajera.png',
                    name: 'Jenil Gajera',
                    title: 'Financial Analyst',
                    description:
                        'Jenil provides insights on market trends and helps you navigate the complexities of financial data to make informed decisions.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget financialGuruCard({
    required String imageUrl,
    required String name,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
            colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(imageUrl),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF6A1B9A), backgroundColor: Colors.white, // button text color
              ),
              child: const Text('Contact Now'),
            ),
          ],
        ),
      ),
    );
  }
}
