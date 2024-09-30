import 'package:flutter/material.dart';

class FinancialTipsScreen extends StatelessWidget {
  const FinancialTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Financial Tips',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Why?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Great financial tips increase financial literacy by providing insight and advice on managing savings, investing, budgeting, and debt management. A better understanding of these concepts enables individuals to make informed decisions regarding their finances.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Financial Tips Cards List
          financialTipCard(
            'Develop a monthly budget to track how you are spending. Allocate funds for expenses, savings, and discretionary spending as necessary to stay on track with your financial goals.',
            isHighlighted: true,
          ),
          financialTipCard(
            'Save 3-6 months\' worth of living expenses in an emergency fund. This will provide financial cushion for unexpected expenses such as medical emergencies or job loss.',
          ),
          financialTipCard(
            'Prioritize paying off high-interest debts, such as credit card debt, to reduce financial stress. This will free up more money for savings and investments.',
          ),
          financialTipCard(
            'For daily expenses, use cash instead of credit to avoid debt. This helps you control your spending and stay within your budget.',
          ),
          financialTipCard(
            'Consider investing in stocks, bonds, or mutual funds to grow your wealth over time and build financial security.',
          ),
          financialTipCard(
            'Allocate 35% of your income towards essential expenses (rent, groceries), 15% to discretionary spending, and 50% to long-term goals (saving, investing, etc.) to create a balanced financial life.',
          ),
          financialTipCard(
            'If you’re unsure about how to manage your debts, consider getting help from a certified financial advisor. They can provide personalized advice to get out of debt.',
          ),
          financialTipCard(
            'Financial literacy is crucial. Start teaching your children about money management, so they grow into financially responsible adults.',
          ),
        ],
      ),
    );
  }

  // Widget function to create a card for each financial tip
  Widget financialTipCard(String tip, {bool isHighlighted = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.purple[100], // Light purple color for the card
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.format_quote,
              color: Colors.black54,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                tip,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
