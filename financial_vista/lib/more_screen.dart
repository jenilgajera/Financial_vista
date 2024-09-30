import 'package:financial_vista/about.dart';
import 'package:financial_vista/finacial_guru.dart';
import 'package:flutter/material.dart';
import 'package:financial_vista/AddExpenseScreen.dart';
import 'package:financial_vista/bill_screen.dart';
import 'package:financial_vista/dashboard.dart';
import 'package:financial_vista/transaction.dart';
import 'package:financial_vista/budget_screen.dart';

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
              _closeSnackBar(context); // Close SnackBar if open
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SaveBillScreen()),
              );
            },
          ),
          CustomListTile(
            icon: Icons.feedback,
            text: 'Feedback',
            onTap: () {
              _closeSnackBar(context); // Close SnackBar if open
              _showFeedbackSnackBar(context);
            },
          ),
          CustomListTile(
            icon: Icons.info_outline,
            text: 'About App',
            onTap: () {
              _closeSnackBar(context); // Close SnackBar if open
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              ); // Close SnackBar if open
            },
          ),
          CustomListTile(
            icon: Icons.school,
            text: 'Financial Guru',
            onTap: () {
              _closeSnackBar(context); // Close SnackBar if open
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FinancialGurusScreen()),
              ); // Close SnackBar if open
            },
          ),
          CustomListTile(
            icon: Icons.lightbulb_outline,
            text: 'Financial Tips',
            onTap: () {
              _closeSnackBar(context); // Close SnackBar if open
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        onPressed: () {
          _closeSnackBar(context); // Close SnackBar if open
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
                _closeSnackBar(context); // Close SnackBar if open
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
                _closeSnackBar(context); // Close SnackBar if open
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
                _closeSnackBar(context); // Close SnackBar if open
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BudgetScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {
                _closeSnackBar(context); // Close SnackBar if open
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to show SnackBar for feedback
  void _showFeedbackSnackBar(BuildContext context) {
    int _rating = 0; // Variable to track the user's rating
    final TextEditingController feedbackController = TextEditingController();

    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.purple[100],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Rate Financial Vista',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Share your feedback with the developer to improve your financial vista',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < _rating
                            ? Icons.star
                            : Icons.star_border, // Filled or outline star
                        color: Colors.black,
                        size: 32,
                      ),
                      onPressed: () {
                        setState(() {
                          _rating = index + 1; // Set the selected rating
                        });
                      },
                    );
                  }),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: feedbackController,
                  decoration: InputDecoration(
                    hintText: 'Write your valuable suggestion here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Close the SnackBar
                    _closeSnackBar(context);
                    // Logic to submit the feedback and rating
                    String feedback = feedbackController.text;
                    print("User's Rating: $_rating");
                    print("User's Feedback: $feedback");
                    // TODO: Send the rating and feedback to your backend or display confirmation
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      duration: Duration(seconds: 50),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(16),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Function to close the SnackBar if it is currently open
  void _closeSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const CustomListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

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
