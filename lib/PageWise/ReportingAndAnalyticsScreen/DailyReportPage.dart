import 'package:flutter/material.dart';
import 'package:medicalstore/Dashboard/DashboardScreen.dart';
import 'DailySaleRecords.dart';
import 'FirebaseInvoice.dart';

class DailyReportPage extends StatefulWidget {
  @override
  _DailyReportPageState createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<DailyReportPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late DateTime selectedDate; // Added selectedDate variable

  Future<List<Map<String, dynamic>>> loadInvoiceData() async {
    final List<Object?> fetchedData =
        await FirebaseHandler.getAllInvoiceData();
    List<Map<String, dynamic>> invoiceDataList =
        fetchedData.cast<Map<String, dynamic>>();
    invoiceDataList.sort((a, b) => a['date'].compareTo(b['date']));

    List<Map<String, dynamic>> filteredList = invoiceDataList.where((invoice) {
      DateTime invoiceDate = DateTime.parse(invoice['date']);
      return invoiceDate.year == selectedDate.year &&
          invoiceDate.month == selectedDate.month &&
          invoiceDate.day == selectedDate.day;
    }).toList();

    return filteredList;
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now().toLocal(); // Initialize selectedDate with current date
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void showNoRecordsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Records Found'),
          content: Text("Sorry, there are no records for the selected date."),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Daily Sale Report'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: loadInvoiceData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error occurred while loading data.'),
            );
          } else {
            List<Map<String, dynamic>> filteredList = snapshot.data ?? [];

            if (filteredList.isEmpty) {
              showNoRecordsDialog(); // Show dialog when no records are found
            }

            int totalInvoices = filteredList.length;
            double grandTotal =
                filteredList.fold(0.0, (sum, invoice) => sum + double.parse(invoice['totalAmount']));

            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: 20.0,
                  child: TextButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );

                      if (pickedDate != null) {
                        onDateSelected(pickedDate);
                      }
                    },
                    child: Text(
                      'Select Date',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          int animatedTotalInvoices =
                              (totalInvoices * _animation.value).toInt();
                          double animatedGrandTotal =
                              grandTotal * _animation.value;

                          return Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.greenAccent.shade200,
                                  Colors.teal.shade300
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Text(
                                  'No of Invoices: $animatedTotalInvoices',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 12.0),
                                Text(
                                  'Total Amount: ₹${animatedGrandTotal.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InvoiceListPage(selectedDate: selectedDate),
                            ),
                          );
                        },
                        child: Text('Details'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
