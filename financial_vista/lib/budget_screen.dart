import 'package:financial_vista/AddExpenseScreen.dart';
import 'package:financial_vista/dashboard.dart';
import 'package:financial_vista/more_screen.dart';
import 'package:financial_vista/transaction.dart';
import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Budget',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(Icons.add, size: 50, color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Show all budget',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            BudgetTile(
              title: 'Bike',
              amountLeft: '₹ 1,000',
              totalAmount: '₹ 1,00,000',
            ),
            BudgetTile(
              title: 'Car',
              amountLeft: '₹ 1,000',
              totalAmount: '₹ 1,00,000',
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
                  MaterialPageRoute(builder: (context) => BudgetScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MoreScreen()),
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

  BudgetTile(
      {required this.title,
      required this.amountLeft,
      required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple[50],
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '$amountLeft left of $totalAmount',
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Icon(Icons.refresh, color: Colors.black),
      ),
    );
  }
}
