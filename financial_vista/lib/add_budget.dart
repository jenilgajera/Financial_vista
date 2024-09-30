import 'package:financial_vista/budget_screen.dart';
import 'package:flutter/material.dart';

class ADD_BUDGET extends StatelessWidget {
  const ADD_BUDGET({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button and Title
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BudgetScreen()),
                      );
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Spacer(),
                  const Icon(Icons
                      .more_vert), // Placeholder for any top right action icon
                ],
              ),
              const SizedBox(height: 20),
              // Bike Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bike',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '₹ 1,000 left of ₹ 1,00,000',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Today's date
                          },
                          child: const Text("Today"),
                        ),
                        const Spacer(),
                        const Text('August 30 - September 30'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: 0.1, // Example value, use actual data here
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'You can spend ₹1000/day for 27 more days',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // History Section
              const Text(
                'History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // History List
              Expanded(
                child: ListView(
                  children: const [
                    HistoryItem(
                      period: 'Current Period',
                      amount: '₹ 1,000 left of ₹ 1,00,000',
                      percentage: '0%',
                    ),
                    HistoryItem(
                      period: 'July 30',
                      amount: '₹ 1,000 left of ₹ 1,00,000',
                      percentage: '0%',
                    ),
                    HistoryItem(
                      period: 'May 30',
                      amount: '₹ 1,000 left of ₹ 1,00,000',
                      percentage: '0%',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom widget for History item
class HistoryItem extends StatelessWidget {
  final String period;
  final String amount;
  final String percentage;

  const HistoryItem({super.key, 
    required this.period,
    required this.amount,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  period,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(amount),
              ],
            ),
            Text(percentage),
          ],
        ),
      ),
    );
  }
}
