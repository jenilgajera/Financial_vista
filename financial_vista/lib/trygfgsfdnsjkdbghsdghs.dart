import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  final String name;
  final String email;

  const DashboardScreen({super.key, required this.name, required this.email});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  double totalBalance = 0;
  double totalIncome = 0;
  double totalExpenses = 0;
  String? uId; // User ID fetched from SharedPreferences

  @override
  void initState() {
    super.initState();
    _fetchUidAndFinancialData();
  }

  Future<void> _fetchUidAndFinancialData() async {
    // Step 1: Fetch u_id from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uId = prefs.getString('u_id');

    if (uId != null) {
      // Step 2: Fetch financial data from Firestore using the fetched u_id
      _fetchFinancialData();
    }
  }

  Future<void> _fetchFinancialData() async {
    // Query the transactions collection where the u_id matches
    try {
      var snapshot = await _db
          .collection('transactions')
          .where('u_id', isEqualTo: uId) // Match transactions for this user
          .get();

      double income = 0;
      double expenses = 0;

      // Step 3: Iterate through the transactions and sum income and expenses
      for (var doc in snapshot.docs) {
        var transactionData = doc.data();
        double amount = transactionData['amount'] ?? 0;
        String type = transactionData['type'] ?? 'expense';

        if (type == 'income') {
          income += amount;
        } else {
          expenses += amount;
        }
      }

      // Step 4: Update the state with fetched income and expense values
      setState(() {
        totalIncome = income;
        totalExpenses = expenses;
        totalBalance = income - expenses;
      });
    } catch (e) {
      print('Error fetching financial data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to Edit Profile
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/image/profileimage.png'),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hope all is fine',
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
                Text(
                  widget.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.black),
              onPressed: () {
                // Navigate to Notification Screen
              },
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Total Balance Display
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFB388FF),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Total Balance',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '₹$totalBalance',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Income and Expenses in Cards
            Row(
              children: [
                // Income Card
                Expanded(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.green[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Income',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.arrow_upward,
                                color: Colors.green,
                                size: 30,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '₹$totalIncome',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Expense Card
                Expanded(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.red[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Expenses',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.arrow_downward,
                                color: Colors.red,
                                size: 30,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '₹$totalExpenses',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
