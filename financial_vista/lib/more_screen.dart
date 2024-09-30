import 'package:financial_vista/AddExpenseScreen.dart';
import 'package:financial_vista/bill_screen.dart';
import 'package:financial_vista/budget_screen.dart';
import 'package:financial_vista/dashboard.dart';
import 'package:financial_vista/transaction.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.purple[100],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          CustomListTile(
            icon: Icons.receipt_long,
            text: 'Save Your Bills',
            onTap: () {
              Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SaveBillScreen()),
          );
            },
          ),

          CustomListTile(
            icon: Icons.feedback,
            text: 'Feedback',
            onTap: () {},
          ),
          CustomListTile(
            icon: Icons.info_outline,
            text: 'About App',
            onTap: () {},
          ),
          CustomListTile(
            icon: Icons.school,
            text: 'Financial Guru',
            onTap: () {},
          ),
          CustomListTile(
            icon: Icons.lightbulb_outline,
            text: 'Financial Tips',
            onTap: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.credit_card),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TransactionScreen()),
                );
              },
            ),
            const SizedBox(width: 40), // space for the FAB
            IconButton(
              icon: const Icon(Icons.wallet),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BudgetScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {
                // Show more options
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const CustomListTile({super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple[50],
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(text),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
