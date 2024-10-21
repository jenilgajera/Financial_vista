import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('about')
            .doc('appDetails')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No data found'));
          } else {
            var data = snapshot.data!.data() as Map<String, dynamic>;

            return SingleChildScrollView(
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
                    Text(
                      data['app_name'] ?? 'FINANCIAL VISTA',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data['description'] ?? 'No description available',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    _buildKeyFeatures(data['key_features']),
                    const SizedBox(height: 20),
                    _buildDevelopmentTeam(data['development_team']),
                    const SizedBox(height: 20),
                    _buildContactSupport(
                        data['contact_email'], data['support_message']),
                    const SizedBox(height: 20),
                    const Text(
                      "MADE IN INDIA 🇮🇳",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildKeyFeatures(List<dynamic>? features) {
    if (features == null || features.isEmpty) {
      return const Text('No key features available');
    }

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
          ...features.map((feature) => _buildFeatureItem(feature)).toList(),
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

  Widget _buildDevelopmentTeam(List<dynamic>? team) {
    if (team == null || team.isEmpty) {
      return const Text('No development team information available');
    }

    return Column(
      children: [
        const Text(
          "Development Team",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...team
            .map((member) => _buildTeamMember(
                member['role'], member['name'], member['email']))
            .toList(),
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

  Widget _buildContactSupport(String? email, String? message) {
    return Column(
      children: [
        const Text(
          "Contact & Support",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          email ?? 'No contact email available',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        Text(
          message ?? 'No support message available',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
