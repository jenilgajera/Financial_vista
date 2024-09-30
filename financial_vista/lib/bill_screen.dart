import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SaveBillScreen extends StatefulWidget {
  const SaveBillScreen({super.key});

  @override
  _SaveBillScreenState createState() => _SaveBillScreenState();
}

class _SaveBillScreenState extends State<SaveBillScreen> {
  DateTime? selectedDate;
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String selectedCategory = 'Maintenance';
  String paidStatus = 'Paid';

  @override
  void dispose() {
    dateController.dispose();
    amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Your Bill'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date field with container styling
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: TextFormField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: 'Enter date',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: InputBorder.none,
                ),
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
              ),
            ),

            const SizedBox(height: 16),

            // Amount field with container styling
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Amount',
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Category dropdown with container styling
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: DropdownButtonFormField<String>(
                value: selectedCategory,
                items: ['Maintenance', 'Electricity', 'Rent', 'Internet']
                    .map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Select category',
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Paid status radio buttons inside container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Paid Status', style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Paid',
                        groupValue: paidStatus,
                        onChanged: (value) {
                          setState(() {
                            paidStatus = value!;
                          });
                        },
                      ),
                      const Text('Paid'),
                      Radio<String>(
                        value: 'Pending',
                        groupValue: paidStatus,
                        onChanged: (value) {
                          setState(() {
                            paidStatus = value!;
                          });
                        },
                      ),
                      const Text('Pending'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Title field with container styling
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  prefixIcon: Icon(Icons.title),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Notes field with container styling
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  prefixIcon: Icon(Icons.note),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Add Bill Button
            ElevatedButton(
              onPressed: () {
                // Logic to add the bill
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Add Bill'),
            ),

            const SizedBox(height: 24),

            // Display bills
            SizedBox(
              height: screenWidth * 0.4, // Dynamic height based on screen width
              child: ListView(
                children: [
                  _buildBillCard('Maintenance', 1000, true),
                  _buildBillCard('Electricity', 2000, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillCard(String title, int amount, bool isPaid) {
    return Card(
      color: Colors.purple.shade100,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          '₹$amount',
          style: const TextStyle(fontSize: 16),
        ),
        trailing: Text(
          isPaid ? 'Paid' : 'Pending',
          style: TextStyle(
            color: isPaid ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
