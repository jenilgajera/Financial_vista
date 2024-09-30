import 'package:financial_vista/add_budget.dart';
import 'package:financial_vista/added_budget_screen.dart';
import 'package:flutter/material.dart';
import 'package:financial_vista/AddExpenseScreen.dart';
// Ensure this import points to your actual AddBudgetScreen
import 'package:financial_vista/dashboard.dart';
import 'package:financial_vista/more_screen.dart';
import 'package:financial_vista/transaction.dart';
// Import for the screen you want to navigate to

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Budget',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const AddBudgetScreens()), // Navigate to AddBudgetScreen
                );
              },
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(Icons.add, size: 50, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  // Implement functionality for 'Show all budget' button
                },
                child: const Text(
                  'Show all budget',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            BudgetTile(
              title: 'Bike',
              amountLeft: '₹ 1,000',
              totalAmount: '₹ 1,00,000',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ADD_BUDGET()), // Navigate to AnotherScreen
                );
              },
            ),
            BudgetTile(
              title: 'Car',
              amountLeft: '₹ 1,000',
              totalAmount: '₹ 1,00,000',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AnotherScreen()), // Navigate to AnotherScreen
                // );
              },
            ),
          ],
        ),
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
                  MaterialPageRoute(builder: (context) => const DashboardScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.credit_card),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TransactionScreen()),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MoreScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BudgetTile extends StatelessWidget {
  final String title;
  final String amountLeft;
  final String totalAmount;
  final VoidCallback onTap; // Added onTap parameter

  const BudgetTile({super.key, 
    required this.title,
    required this.amountLeft,
    required this.totalAmount,
    required this.onTap, // Required parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Call the onTap function
      child: Card(
        color: Colors.purple[50],
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '$amountLeft left of $totalAmount',
            style: TextStyle(color: Colors.grey[600]),
          ),
          trailing: const Icon(Icons.refresh, color: Colors.black),
        ),
      ),
    );
  }
}
