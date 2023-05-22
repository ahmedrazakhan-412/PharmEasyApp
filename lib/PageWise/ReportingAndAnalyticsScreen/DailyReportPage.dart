import 'package:flutter/material.dart';
import 'package:medicalstore/Dashboard/DashboardScreen.dart';
import 'DailySaleRecords.dart';
import 'FirebaseInvoice.dart';

class DailyReportPage extends StatefulWidget {
  @override
  _DailyReportPageState createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<DailyReportPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  Future<List<Map<String, dynamic>>> loadInvoiceData() async {
    final List<Object?> fetchedData = await FirebaseHandler.getAllInvoiceData();
    List<Map<String, dynamic>> invoiceDataList = fetchedData.cast<Map<String, dynamic>>();
    invoiceDataList.sort((a, b) => a['date'].compareTo(b['date']));

    DateTime currentDate = DateTime.now().toLocal();
    List<Map<String, dynamic>> filteredList = invoiceDataList.where((invoice) {
      DateTime invoiceDate = DateTime.parse(invoice['date']);
      return invoiceDate.year == currentDate.year &&
          invoiceDate.month == currentDate.month &&
          invoiceDate.day == currentDate.day;
    }).toList();

    return filteredList;
  }

  @override
  void initState() {
    super.initState();
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

            int totalInvoices = filteredList.length;
            double grandTotal = filteredList.fold(0.0, (sum, invoice) => sum + double.parse(invoice['totalAmount']));

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      int animatedTotalInvoices = (totalInvoices * _animation.value).toInt();
                      double animatedGrandTotal = grandTotal * _animation.value;

                      return Column(
                        children: [
                          Text(
                            'No of Invoices: $animatedTotalInvoices',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Total Amount: \Rs.${animatedGrandTotal.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InvoiceListPage()),
                      );
                    },
                    child: Text('Details'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
