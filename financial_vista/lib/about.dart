import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'About',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/image/potly.png', // Replace with your image asset path
                height: 120,
              ),
              const SizedBox(height: 20),
              const Text(
                "FINANCIAL VISTA",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Expense Manager is your go-to app for tracking your daily expenses, budgeting your finances, and gaining insights into your spending habits.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              _buildKeyFeatures(),
              const SizedBox(height: 20),
              _buildDevelopmentTeam(),
              const SizedBox(height: 20),
              _buildContactSupport(),
              const SizedBox(height: 20),
              const Text(
                "MADE IN INDIA 🇮🇳",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildKeyFeatures() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EBF8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Key Features",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildFeatureItem("Track Expense"),
          _buildFeatureItem("Budget Planning"),
          _buildFeatureItem("Reports & Analytics"),
          _buildFeatureItem("Secure & Private"),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: Colors.black, size: 20),
        const SizedBox(width: 10),
        Text(feature, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildDevelopmentTeam() {
    return Column(
      children: [
        const Text(
          "Development Team",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildTeamMember("Lead Development", "abc", "rku.ac.in"),
        const SizedBox(height: 10),
        _buildTeamMember("Database designer", "abc", "rku.ac.in"),
      ],
    );
  }

  Widget _buildTeamMember(String role, String name, String email) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EBF8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            role,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(name, style: const TextStyle(fontSize: 16)),
          Text(email, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildContactSupport() {
    return const Column(
      children: [
        Text(
          "Contact & Support",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          "Email: support@expmanger.com",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Text(
          "We value your feedback! Rate us on the App Store or Google Play to help us improve.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
