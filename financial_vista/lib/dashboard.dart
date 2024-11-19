import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:financial_vista/AddExpenseScreen.dart';
import 'package:financial_vista/budget_screen.dart';
import 'package:financial_vista/edit_profile.dart';
import 'package:financial_vista/more_screen.dart';
import 'package:financial_vista/notification.dart';
import 'package:financial_vista/transaction.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<BarChartGroupData> barGroups = [];
  double totalBalance = 0;
  double totalIncome = 0;

  double totalExpenses = 0;
  String? uId; // User ID fetched from SharedPreferences
  String userName = 'Loading...'; // Placeholder for username
  int currentStartDay = 1; // Track the starting day of the range to show
  int daysToShow = 5; // Number of days to show at once (5 days)

  @override
  void initState() {
    super.initState();
    _resetDashboardState();
    _fetchFinancialData();
    _fetchUidAndFinancialData();
    _fetchUsername();
  }

  Future<void> _resetDashboardState() async {
    // Reset all variables to their default values
    setState(() {
      totalBalance = 0;
      totalIncome = 0;
      totalExpenses = 0;
      userName = 'Loading...'; // Reset the username
      uId = null; // Clear the stored u_id
    });
  }

  Future<void> _fetchUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uId = prefs.getString('u_id');

    if (uId != null) {
      try {
        // Fetch user document from the 'users' collection where u_id matches
        var userSnapshot = await _db.collection('users').doc(uId).get();

        if (userSnapshot.exists) {
          // Retrieve and update the username
          String fetchedName = userSnapshot.data()?['username'] ?? 'User';

          setState(() {
            userName = fetchedName; // Update the username to display
          });
        } else {
          setState(() {
            userName = 'User not found'; // Handle user not found case
          });
        }
      } catch (e) {
        print('Error fetching username: $e');
        setState(() {
          userName = 'Error'; // Handle errors
        });
      }
    }
  }

  Future<void> _fetchUidAndFinancialData() async {
    // Step 1: Fetch u_id from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? newUId = prefs.getString('u_id');

    // Step 2: Check if the uId has changed (new user login)
    if (newUId != uId) {
      // Reset financial data if a new user has logged in
      await _resetDashboardState(); // Await the reset to complete before fetching new data
    }

    // Step 3: Update the uId to the new value and fetch the financial data
    uId = newUId;

    if (uId != null) {
      // Step 4: Fetch financial data from Firestore using the fetched u_id
      await _fetchFinancialData(); // Await financial data fetch
    }
  }

  Future<void> _fetchFinancialData() async {
    if (uId == null) return;

    try {
      var snapshot = await _db
          .collection('transactions')
          .where('user_id', isEqualTo: uId)
          .get();

      Map<String, double> dailyIncome = {};
      Map<String, double> dailyExpenses = {};

      for (var doc in snapshot.docs) {
        var transactionData = doc.data();
        double amount = transactionData['amount'] ?? 0;
        String type = transactionData['type']?.toLowerCase() ?? 'expense';
        Timestamp timestamp = transactionData['date'];
        DateTime date = timestamp.toDate();

        // Use a formatted date string as the key (e.g., "16-Nov")
        String dayKey = "${date.day}-${DateFormat('MMM').format(date)}";

        if (type == 'income') {
          dailyIncome[dayKey] = (dailyIncome[dayKey] ?? 0) + amount;
        } else if (type == 'expense') {
          dailyExpenses[dayKey] = (dailyExpenses[dayKey] ?? 0) + amount;
        }
      }

      // Update the state to create the bar chart data
      setState(() {
        barGroups = [];
        for (int i = currentStartDay;
            i < currentStartDay + daysToShow && i <= 31;
            i++) {
          // Generate key using i (day number)
          String dayKey = "$i-${DateFormat('MMM').format(DateTime.now())}";

          double income = dailyIncome[dayKey] ?? 0;
          double expenses = dailyExpenses[dayKey] ?? 0;

          barGroups.add(BarChartGroupData(
            x: i - 1, // Ensure it aligns correctly on x-axis
            barRods: [
              BarChartRodData(
                toY: income,
                color: Colors.green,
                width: 16,
              ),
              BarChartRodData(
                toY: expenses,
                color: Colors.red,
                width: 16,
              ),
            ],
          ));
        }

        totalIncome = dailyIncome.values.fold(0, (sum, item) => sum + item);
        totalExpenses = dailyExpenses.values.fold(0, (sum, item) => sum + item);
        totalBalance = totalIncome - totalExpenses;
      });
    } catch (e) {
      print('Error fetching financial data: $e');
    }
  }

  // Method to go to the next 5 days
  void _nextPage() {
    setState(() {
      if (currentStartDay + daysToShow <= 31) {
        currentStartDay += daysToShow;
      }
      _fetchFinancialData(); // Re-fetch the data for the new range
    });
  }

  // Method to go to the previous 5 days
  void _previousPage() {
    setState(() {
      if (currentStartDay - daysToShow >= 1) {
        currentStartDay -= daysToShow;
      }
      _fetchFinancialData(); // Re-fetch the data for the new range
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditProfileScreen()),
                );
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
                  userName, // Display the fetched username here
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationScreen()),
                );
              },
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // BackContainer
            Positioned(
              top: 10,
              left: 15,
              right: 15,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFE1BEE7),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              ),
            ),

            // Main Container
            Positioned(
              top: 30,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFB388FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Expenses Section
                        Row(
                          children: [
                            const Icon(Icons.arrow_downward, color: Colors.red),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Expenses',
                                    style: TextStyle(color: Colors.white)),
                                Text(
                                  '₹$totalExpenses',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Income Section
                        Row(
                          children: [
                            const Icon(Icons.arrow_upward, color: Colors.green),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Income',
                                    style: TextStyle(color: Colors.white)),
                                Text(
                                  '₹$totalIncome',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Second Container (Net Worth)
            Positioned(
              top: 250,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 192, 80, 115),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Net Worth',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '₹$totalBalance',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bar Chart Container
            Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: Container(
                height: 330,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: BarChart(BarChartData(
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          int day = value.toInt() + 1;
                          return Text(
                            "$day", // Display the day number
                            style: const TextStyle(
                                color: Colors.black, fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: barGroups,
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                )),
              ),
            ),
            // Pagination Controls
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: _previousPage,
                  ),
                  Text(
                      'Days ${currentStartDay} - ${currentStartDay + daysToShow - 1}'),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.black),
                    onPressed: _nextPage,
                  ),
                ],
              ),
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
