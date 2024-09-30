import 'package:financial_vista/guru1.dart';
import 'package:financial_vista/guru2.dart';
import 'package:financial_vista/guru3.dart';
import 'package:flutter/material.dart';

class FinancialGuruScreen extends StatelessWidget {
  const FinancialGuruScreen({Key? key}) : super(key: key);

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
              // Welcome message container similar to the provided image
              buildWelcomeContainer(),
              const SizedBox(height: 16),

              // First Guru Container
              buildGuruContainer(
                context: context,
                imageUrl: 'assets/image/nenis.png', // Local image
                name: 'Nenis Rudani',
                title: 'Personal Finance & Investment Advisor',
                description:
                    'A Personal Finance Advisor helps you manage your personal finances effectively. Whether it\'s budgeting, saving, or managing debt, they provide personalized strategies to help you achieve financial stability and meet your financial goals.',
                buttonText: 'Consult a Guru',
                onButtonPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Guru1()),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Second Guru Container
              buildGuruContainer(
                context: context,
                imageUrl: 'assets/image/krupansu.png', // Local image
                name: 'Krupansu Sorathiya',
                title: 'Tax and Debt Management Consultant',
                description:
                    'Krupansu assists clients in effectively managing taxes and debt while providing personalized strategies to achieve financial stability.',
                buttonText: 'Consult a Guru',
                onButtonPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Guru2()),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Third Guru Container
              buildGuruContainer(
                context: context,
                imageUrl: 'assets/image/jenil.png', // Local image
                name: 'Jenil Gajera',
                title: 'Financial Coach',
                description:
                    'A Financial Coach provides personalized coaching to help you develop positive financial habits, overcome money challenges, and achieve your financial goals.',
                buttonText: 'Consult a Guru',
                onButtonPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Guru3()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build Welcome Container like the image you provided
  Widget buildWelcomeContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF6EEFF), // Light purple background color
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.format_quote,
            color: Colors.black,
            size: 40,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Welcome to the Financial Guru service, your personal guide to financial success. Our team of expert financial advisors is here to help you make informed decisions, plan for the future, and achieve your financial goals with confidence.',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  // Method to build each Guru Container
  Widget buildGuruContainer({
    required BuildContext context,
    required String imageUrl,
    required String name,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onButtonPressed,
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

                // Description
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Button
                Container(
                  width: double
                      .infinity, // Makes the button take full width of the parent container
                  child: ElevatedButton(
                    onPressed: onButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
