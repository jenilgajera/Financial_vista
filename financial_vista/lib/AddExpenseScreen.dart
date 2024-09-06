import 'package:financial_vista/dashboard.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
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
              // Expense/Income Toggle
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
              // Show relevant form based on the selected type
              _selectedType == 'Expense'
                  ? _buildExpenseForm()
                  : _buildIncomeForm(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFE8DAFF),
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: SizedBox(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                iconSize: 40,
                color: const Color(0xFF6F35A5),
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
                iconSize: 35,
                color: const Color(0xFF6F35A5),
                onPressed: () {},
              ),
              const SizedBox(width: 20), // Space for the FloatingActionButton
              IconButton(
                icon: const Icon(Icons.account_balance_wallet),
                iconSize: 33,
                color: const Color(0xFF6F35A5),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                iconSize: 35,
                color: const Color(0xFF6F35A5),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          );
        },
        backgroundColor: const Color(0xFF6F35A5),
        elevation: 5.0,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
          color: _selectedType == text ? Colors.deepPurple : Colors.grey[200],
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
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
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

  Widget _buildExpenseForm() {
    return Column(
      children: [
        _buildDatePicker(),
        const SizedBox(height: 20),
        _buildTextField(_amountController, 'Enter Amount'),
        const SizedBox(height: 20),
        _buildTextField(_categoryController, 'Select category'),
        const SizedBox(height: 20),
        _buildTextField(_titleController, 'Title'),
        const SizedBox(height: 20),
        _buildTextField(_notesController, 'Notes', maxLines: 3),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Handle add expense action
            },
            child: const Text(
              'Add Expense',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
        _buildTextField(_categoryController, 'Select category'),
        const SizedBox(height: 20),
        _buildTextField(_titleController, 'Title'),
        const SizedBox(height: 20),
        _buildTextField(_notesController, 'Notes', maxLines: 3),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Handle add income action
            },
            child: const Text(
              'Add Income',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
