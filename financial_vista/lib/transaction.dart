import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_vista/AddExpenseScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String? uId; // To store the logged-in user's u_id

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  // Load the user ID from SharedPreferences
  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uId = prefs.getString('u_id');
    });

    // Debug log to check if uId is loaded correctly
    if (uId != null) {
      print('User ID loaded from SharedPreferences: $uId');
    } else {
      print('User ID is null. Please check if it is being set correctly.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Transactions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: uId == null
          ? const Center(
              child: CircularProgressIndicator(),
            ) // Wait for uId to load
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('transactions')
                  .where('user_id',
                      isEqualTo: uId) // Filter by logged-in user's u_id
                  .orderBy('date',
                      descending: true) // Order by date, most recent first
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  // Print the Firestore error for debugging
                  print('Firestore Error: ${snapshot.error}');

                  // Check if error is related to missing index
                  if (snapshot.error
                      .toString()
                      .contains('FAILED_PRECONDITION')) {
                    return const Center(
                      child: Text(
                        'Error: Missing Firestore index. Go to the Firebase console to create the required index.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  return const Center(
                    child: Text('Error fetching transactions'),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No transactions found'));
                }

                // Data is available
                List<DocumentSnapshot> transactions = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> transactionData =
                        transactions[index].data() as Map<String, dynamic>;

                    return TransactionTile(
                      category: transactionData['category'] ?? 'Unknown',
                      description: transactionData['title'] ?? 'No description',
                      amount: _formatAmount(
                          transactionData['amount'], transactionData['type']),
                      date: transactionData['date'].toDate(),
                      color: _getCategoryColor(transactionData['category']),
                      icon: _getCategoryIcon(transactionData['category']),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Helper method to format amount based on transaction type (Income/Expense)
  String _formatAmount(double amount, String type) {
    return type == 'Income'
        ? '+₹${amount.toStringAsFixed(2)}'
        : '-₹${amount.toStringAsFixed(2)}';
  }

  // Helper method to get color based on category
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.redAccent;
      case 'Shopping':
        return Colors.orangeAccent;
      case 'Gift':
        return Colors.greenAccent;
      case 'Salary':
        return Colors.lightBlueAccent;
      default:
        return Colors.grey;
    }
  }

  // Helper method to get icon based on category
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.fastfood;
      case 'Shopping':
        return Icons.shopping_bag;
      case 'Gift':
        return Icons.card_giftcard;
      case 'Salary':
        return Icons.account_balance_wallet;
      default:
        return Icons.category;
    }
  }
}

class TransactionTile extends StatelessWidget {
  final String category;
  final String description;
  final String amount;
  final DateTime date;
  final Color color;
  final IconData icon;

  const TransactionTile({
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
    required this.color,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(description, style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 5),
              Text(DateFormat('MMM dd, yyyy').format(date), // Display date
                  style: TextStyle(color: Colors.grey[500])),
            ],
          ),
          const Spacer(),
          Text(
            amount,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: amount.contains('-') ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
