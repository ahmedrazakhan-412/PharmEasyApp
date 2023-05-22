import 'package:flutter/material.dart';
import 'FirebaseInvoice.dart';

class InvoiceListPage extends StatefulWidget {
  @override
  _InvoiceListPageState createState() => _InvoiceListPageState();
}

class _InvoiceListPageState extends State<InvoiceListPage> {
  List<Map<String, dynamic>> invoiceDataList = [];
  late DateTime selectedDate = DateTime.now();  // Add selectedDate variable
  double grandTotal = 0.0; // Add grandTotal variable

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

List<Map<String, dynamic>> getFilteredInvoiceData() {
  if (selectedDate == null) {
    return invoiceDataList;
  } else {
    final selectedDateString = selectedDate.toLocal().toString().split(' ')[0];
    return invoiceDataList
        .where((invoice) =>
            invoice['date'].toString().split(' ')[0] == selectedDateString)
        .toList();
  }
}

  void _showUserInfoDialog(BuildContext context, Map<String, dynamic> invoiceData) {
  final filteredInvoiceData = getFilteredInvoiceData();
  if (filteredInvoiceData.isEmpty) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Records'),
          content: Text('Sorry, there are no records for the selected date.'),
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
  } else {
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
}


 @override
Widget build(BuildContext context) {
  final filteredInvoiceData = getFilteredInvoiceData(); // Filtered invoice data based on selected date
  final filteredGrandTotal = filteredInvoiceData.fold(0.0, (total, invoice) => total + double.parse(invoice['totalAmount']));

  return Scaffold(
    appBar: AppBar(
      title: Text('Invoice List'),
    ),
    body: Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedDate == null
                    ? 'All Invoices'
                    : 'Invoices for ${selectedDate.toString().split(' ')[0]}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              TextButton(
                child: Text(
                  'Select Date',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => _selectDate(context),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredInvoiceData.length,
            itemBuilder: (context, index) {
              final invoiceData = filteredInvoiceData[index];
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
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Grand Total: $filteredGrandTotal',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    ),
  );
}
}