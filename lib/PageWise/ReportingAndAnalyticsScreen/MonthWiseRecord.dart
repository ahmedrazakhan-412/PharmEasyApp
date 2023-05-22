import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'FirebaseInvoice.dart';

class MonthWiseReport extends StatefulWidget {
  @override
  _MonthWiseReportState createState() => _MonthWiseReportState();
}

class _MonthWiseReportState extends State<MonthWiseReport> {
  List<Map<String, dynamic>> invoiceDataList = [];
  List<Map<String, dynamic>> displayedInvoiceData = [];
  DateTime selectedFromDate = DateTime.now().toLocal();
  DateTime selectedToDate = DateTime.now().toLocal();
  double grandTotal = 0.0;

  @override
  void initState() {
    super.initState();
    loadInvoiceData();
  }

  Future<void> loadInvoiceData() async {
    final List<Object?> fetchedData = await FirebaseHandler.getAllInvoiceData();
    invoiceDataList = fetchedData.cast<Map<String, dynamic>>();
    invoiceDataList.sort((a, b) => a['date'].compareTo(b['date']));
    setState(() {
      selectedFromDate = DateTime.now().toLocal();
      selectedToDate = DateTime.now().toLocal();
      displayedInvoiceData = invoiceDataList;
    });
  }

  Future<void> _selectDate(BuildContext context, String dateType) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateType == 'from' ? selectedFromDate : selectedToDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (dateType == 'from') {
          selectedFromDate = picked;
        } else {
          selectedToDate = picked;
        }
      });
    }
  }

  void getFilteredInvoiceData(DateTime fromDate, DateTime toDate) {
    final filteredList = invoiceDataList.where((invoice) {
      final dynamic invoiceDate = invoice['date'];
      if (invoiceDate is String) {
        final DateTime convertedDate = DateTime.parse(invoiceDate);
        return convertedDate.isAfter(fromDate) && convertedDate.isBefore(toDate);
      } else if (invoiceDate is Timestamp) {
        return invoiceDate.toDate().isAfter(fromDate) && invoiceDate.toDate().isBefore(toDate);
      }
      return false;
    }).toList();

    setState(() {
      displayedInvoiceData = filteredList;
    });
  }

  void _showUserInfoDialog(BuildContext context, Map<String, dynamic> invoiceData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invoice Information'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Invoice Number: ${invoiceData['invoiceNumber']}'),
              Text('Customer Name: ${invoiceData['customerName']}'),
              Text('Customer Address: ${invoiceData['customerAddress']}'),
              Text('Customer Contact: ${invoiceData['customerContact']}'),
              Text('Date: ${invoiceData['date']}'),
              Text('Due Date: ${invoiceData['dueDate']}'),
              Text('Payment Terms: ${invoiceData['paymentTerms']}'),
              Text('Payment Method: ${invoiceData['paymentMethod']}'),
              Text('Description: ${invoiceData['description']}'),
              Row(
                children: [
                  Text('Item Description: '),
                  Expanded(child: Text('${invoiceData['itemDescription']}')),
                ],
              ),
              Row(
                children: [
                  Text('Quantity: '),
                  Expanded(child: Text('${invoiceData['quantity']}')),
                ],
              ),
              Row(
                children: [
                  Text('Unit Price: '),
                  Expanded(child: Text('${invoiceData['unitPrice']}')),
                ],
              ),
              Text('Tax Rate: ${invoiceData['taxRate']}'),
              Text('Discount: ${invoiceData['discount']}'),
              Text('Subtotal: ${invoiceData['subtotal']}'),
              Text('Total Amount: ${invoiceData['totalAmount']}'),
            ],
          ),
          actions: [
            ElevatedButton(
              child: Text('Close'),
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
    final filteredGrandTotal = displayedInvoiceData.fold(
        0.0,
        (total, invoice) =>
            total + double.parse(invoice['totalAmount'] ?? '0.0'));

    return Scaffold(
      appBar: AppBar(
        title: Text('Month Wise Report'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Month wise details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.date_range),
                      onPressed: () => _selectDate(context, 'from'),
                    ),
                    Text(
                      'From: ${selectedFromDate.toString().split(' ')[0]}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.date_range),
                      onPressed: () => _selectDate(context, 'to'),
                    ),
                    Text(
                      'To: ${selectedToDate.toString().split(' ')[0]}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Search'),
                      onPressed: () {
                        getFilteredInvoiceData(selectedFromDate, selectedToDate);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedInvoiceData.length,
              itemBuilder: (context, index) {
                final invoiceData = displayedInvoiceData[index];
                final seriesNumber = index + 1;

                return ListTile(
                  onTap: () {
                    _showUserInfoDialog(context, invoiceData);
                  },
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.teal[600],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$seriesNumber',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Invoice Number: ${invoiceData['invoiceNumber']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Grand Total: $filteredGrandTotal',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
