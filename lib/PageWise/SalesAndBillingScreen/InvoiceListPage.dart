import 'package:flutter/material.dart';
import 'FirebaseInvoice.dart';

class InvoiceListPage extends StatefulWidget {
  @override
  _InvoiceListPageState createState() => _InvoiceListPageState();
}
class _InvoiceListPageState extends State<InvoiceListPage> {
  List<Map<String, dynamic>> invoiceDataList = [];

  @override
  void initState() {
    super.initState();
    loadInvoiceData();
  }

  Future<void> loadInvoiceData() async {
    final List<Object?> fetchedData = await FirebaseHandler.getAllInvoiceData();
    invoiceDataList = fetchedData.cast<Map<String, dynamic>>();
    invoiceDataList.sort((a, b) => a['date'].compareTo(b['date']));
    setState(() {});
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
            TextButton(
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice List'),
      ),
      body: ListView.builder(
        itemCount: invoiceDataList.length,
        itemBuilder: (context, index) {
          final invoiceData = invoiceDataList[index];
          final seriesNumber = index + 1; // Calculate series number based on index after sorting

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
    );
  }
}
