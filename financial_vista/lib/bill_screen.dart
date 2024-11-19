import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart'; // Path provider import
import 'dart:io';

class SaveBillScreen extends StatefulWidget {
  const SaveBillScreen({super.key});

  @override
  _SaveBillScreenState createState() => _SaveBillScreenState();
}

class _SaveBillScreenState extends State<SaveBillScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  DateTime? selectedDate;
  String selectedCategory = 'Maintenance';
  String paidStatus = 'Paid';
  String? uId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uId = prefs.getString('u_id') ?? 'default_user_id';
    });
  }

  Future<void> _saveBill() async {
    if (uId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User ID not found. Please log in.')),
      );
      return;
    }

    final billData = {
      'date': dateController.text,
      'amount': amountController.text,
      'category': selectedCategory,
      'status': paidStatus,
      'title': titleController.text,
      'notes': notesController.text,
      'u_id': uId,
    };

    try {
      await FirebaseFirestore.instance.collection('bills').add(billData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bill added successfully')),
      );
      _clearFields();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add bill: $e')),
      );
    }
  }

  void _clearFields() {
    dateController.clear();
    amountController.clear();
    titleController.clear();
    notesController.clear();
    setState(() {
      selectedCategory = 'Maintenance';
      paidStatus = 'Paid';
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        dateController.text =
            "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
      });
    }
  }

  Future<void> _generatePdf(List<Map<String, dynamic>> bills) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Bills Report',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 16),
              pw.Table.fromTextArray(
                headers: ['Date', 'Title', 'Amount', 'Category', 'Status'],
                data: bills.map((bill) {
                  return [
                    bill['date'],
                    bill['title'],
                    bill['amount'],
                    bill['category'],
                    bill['status']
                  ];
                }).toList(),
              ),
            ],
          );
        },
      ),
    );

    try {
      final output = await getTemporaryDirectory(); // Make sure this works
      final file = File("${output.path}/bills_report.pdf");
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF saved at ${file.path}'),
          action: SnackBarAction(
            label: 'Open',
            onPressed: () {
              // Add logic to open the PDF if necessary.
            },
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Your Bill'),
        backgroundColor: Colors.purple[300],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () async {
              final bills = await _fetchBills();
              if (bills.isNotEmpty) {
                await _generatePdf(bills);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('No bills available to generate PDF.')),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Select date',
                        hintText: 'mm/dd/yyyy',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Enter Amount',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      items: ['Maintenance', 'Electricity', 'Rent', 'Internet']
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Select category',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            value: 'Paid',
                            groupValue: paidStatus,
                            title: const Text('Paid'),
                            onChanged: (value) {
                              setState(() {
                                paidStatus = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            value: 'Pending',
                            groupValue: paidStatus,
                            title: const Text('Pending'),
                            onChanged: (value) {
                              setState(() {
                                paidStatus = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: notesController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Notes',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _saveBill,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[300],
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                      ),
                      child: const Text('Add Bill'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Bills',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              _buildBillsList(),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchBills() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('bills')
        .where('u_id', isEqualTo: uId)
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Widget _buildBillsList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchBills(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No bills found.'));
        }
        final bills = snapshot.data!;
        return Column(
          children: bills.map((bill) {
            return _buildBillCard(
              bill['title'] ?? 'N/A',
              '₹${bill['amount'] ?? '0'}',
              bill['status'] ?? 'Pending',
              bill['status'] == 'Paid' ? Colors.green : Colors.red,
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildBillCard(
      String title, String amount, String status, Color statusColor) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            amount,
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Icon(
                status == 'Paid' ? Icons.check_circle : Icons.cancel,
                color: statusColor,
              ),
              const SizedBox(width: 4.0),
              Text(
                status,
                style: TextStyle(color: statusColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
