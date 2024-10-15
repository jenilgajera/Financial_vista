import 'package:financial_vista/budget_screen.dart';
import 'package:financial_vista/more_screen.dart';
import 'package:financial_vista/transaction.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_vista/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  String _selectedType = 'Expense';
  DateTime? _selectedDate;
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  String? uId; // Variable to hold user ID

  @override
  void initState() {
    super.initState();
    _loadUserId(); // Load user ID from SharedPreferences
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uId = prefs.getString('u_id'); // Fetch user ID
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedType == 'Expense' ? 'Add Expense' : 'Add Income'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: const Color(0xFFE8DAFF), // Light purple background
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildToggleOption('Expense'),
                  ),
                  Expanded(
                    child: _buildToggleOption('Income'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _selectedType == 'Expense'
                  ? _buildExpenseForm()
                  : _buildIncomeForm(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          // Handle adding a new entry
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
                      builder: (context) => const DashboardScreen(
                           
                          )),
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

  Widget _buildToggleOption(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = text;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _selectedType == text ? Colors.purple : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: _selectedType == text ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select date',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null && pickedDate != _selectedDate) {
              setState(() {
                _selectedDate = pickedDate;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(
                  _selectedDate == null
                      ? 'Enter date'
                      : '${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}',
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                const Icon(Icons.calendar_today, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {int maxLines = 1, bool readOnly = false, Function()? onTap}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Firestore category selection
  Widget _buildFirestoreCategoryField() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('cat').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error loading categories');
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No categories available');
        }

        List<DropdownMenuItem<String>> categoryItems = snapshot.data!.docs
            .map((doc) => DropdownMenuItem<String>(
                  value: doc['cat_name'], // Use the category name
                  child: Text(doc['cat_name']),
                ))
            .toList();

        return DropdownButtonFormField<String>(
          value: _categoryController.text.isNotEmpty
              ? _categoryController.text
              : null,
          hint: const Text('Select Category'),
          items: categoryItems,
          onChanged: (value) {
            setState(() {
              _categoryController.text = value!; // Update category
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        );
      },
    );
  }

  Widget _buildExpenseForm() {
    return Column(
      children: [
        _buildDatePicker(),
        const SizedBox(height: 20),
        _buildTextField(_amountController, 'Enter Amount'),
        const SizedBox(height: 20),
        _buildFirestoreCategoryField(), // Updated to use Firestore categories
        const SizedBox(height: 20),
        _buildTextField(_titleController, 'Title'),
        const SizedBox(height: 20),
        _buildTextField(_notesController, 'Notes', maxLines: 3),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _addEntry('Expense');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Add Expense',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIncomeForm() {
    return Column(
      children: [
        _buildDatePicker(),
        const SizedBox(height: 20),
        _buildTextField(_amountController, 'Enter Amount'),
        const SizedBox(height: 20),
        _buildFirestoreCategoryField(), // Updated to use Firestore categories
        const SizedBox(height: 20),
        _buildTextField(_titleController, 'Title'),
        const SizedBox(height: 20),
        _buildTextField(_notesController, 'Notes', maxLines: 3),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _addEntry('Income');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Add Income',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _addEntry(String type) async {
    if (uId == null) {
      print('User ID is not available');
      return;
    }
    if (_amountController.text.isEmpty ||
        _categoryController.text.isEmpty ||
        _titleController.text.isEmpty ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    // Prepare the data to insert
    final entry = {
      'amount': double.tryParse(_amountController.text),
      'category': _categoryController.text,
      'title': _titleController.text,
      'notes': _notesController.text,
      'date': _selectedDate,
      'type': type,
      'user_id': uId, // Add user ID to the entry
    };

    // Add entry to Firestore
    await FirebaseFirestore.instance.collection('transactions').add(entry);

    // Show a success Snackbar and navigate to TransactionScreen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Transaction added successfully!'),
        duration: Duration(
            seconds: 3), // Change this duration to hide after 3 seconds
      ),
    );

    // Delay the navigation for 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TransactionScreen()),
      );
    });

    // Clear input fields
    _amountController.clear();
    _categoryController.clear();
    _titleController.clear();
    _notesController.clear();
    setState(() {
      _selectedDate = null;
    });
  }
}
