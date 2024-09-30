import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the date

class AddBudgetScreens extends StatefulWidget {
  const AddBudgetScreens({super.key});

  @override
  _AddBudgetScreensState createState() => _AddBudgetScreensState();
}

class _AddBudgetScreensState extends State<AddBudgetScreens> {
  final _totalAmountController = TextEditingController();
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Initialize dateController with the current month and year
    _dateController.text = DateFormat('MMMM yyyy').format(_selectedDate);
  }

  @override
  void dispose() {
    _totalAmountController.dispose();
    _titleController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('MMMM yyyy').format(_selectedDate);
      });
    }
  }

  void _handleAddBudget() {
    // Handle add budget logic here
    final totalAmount = _totalAmountController.text;
    final title = _titleController.text;
    final notes = _notesController.text;
    final date = _dateController.text;

    // Example: print values
    print('Total Amount: $totalAmount');
    print('Title: $title');
    print('Notes: $notes');
    print('Date: $date');

    // For now, show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Budget added successfully!')),
    );
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Add Budget',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Text(
                      '₹0 / 1 month',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'beginning August 1',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Current period: August 1 - August 31',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Total Amount Input Field
              TextField(
                controller: _totalAmountController,
                decoration: InputDecoration(
                  labelText: 'Total Amount',
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.purple[50]!),
                  ),
                  filled: true,
                  fillColor: Colors.purple[50],
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              // Title Input Field
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  suffixIcon: const Icon(Icons.title, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.purple[50]!),
                  ),
                  filled: true,
                  fillColor: Colors.purple[50],
                ),
              ),
              const SizedBox(height: 20),
              // Notes Input Field
              TextField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'Notes',
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  suffixIcon: const Icon(Icons.note, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.purple[50]!),
                  ),
                  filled: true,
                  fillColor: Colors.purple[50],
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              // Date Input Field

              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _handleAddBudget,
                  child: const Text(
                    'Add Budget',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
