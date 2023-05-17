import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class BillingModule extends StatefulWidget {
  @override
  _BillingModuleState createState() => _BillingModuleState();
}

class _BillingModuleState extends State<BillingModule> {
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  TextEditingController customerContactController = TextEditingController();
  TextEditingController invoiceNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController paymentTermsController = TextEditingController();
  TextEditingController paymentMethodController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController unitPriceController = TextEditingController();
  TextEditingController taxRateController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  DateTime selectedDueDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDueDate = DateTime.now();
  }

  void _generateBill() {
    // Generate the bill logic
    // You can access the entered data using the text controllers

    // Example: Printing the bill to the console
    print('Customer Name: ${customerNameController.text}');
    // ... print other data

    // Show the dialog with print and save options
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bill Generated'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Customer Name: ${customerNameController.text}'),
              Text('Customer Address: ${customerAddressController.text}'),
              Text('Customer Contact: ${customerContactController.text}'),
              Text('Invoice/Receipt Number: ${invoiceNumberController.text}'),
              Text('Date: ${dateController.text}'),
              Text('Due Date: ${dueDateController.text}'),
              Text('Payment Terms: ${paymentTermsController.text}'),
              Text('Payment Method: ${paymentMethodController.text}'),
              Text('Description: ${descriptionController.text}'),
              Row(
                children: [
                  Text('Item Description: \n${itemDescriptionController.text}'),
                  SizedBox(width: 16.0),
                  Text('Quantity: \n${quantityController.text}'),
                  SizedBox(width: 16.0),
                  Text('Unit Price: \n${unitPriceController.text}'),
                ],
              ),
              Text('Tax Rate: ${taxRateController.text}'),
              Text('Discount: ${discountController.text}'),
              SizedBox(height: 16),
              Text('Subtotal: ${calculateSubtotal().toStringAsFixed(2)}'),
              SizedBox(height: 8),
              Text(
                'Total Amount: ${calculateTotalAmount().toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Print option functionality
                // Implement your printing logic here
                print('Printing the bill...');
              },
              child: Text('Print'),
            ),
            TextButton(
              onPressed: () {
                // Save option functionality
                // Implement your saving logic here
                print('Saving the bill...');
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  double calculateSubtotal() {
    double quantity = double.tryParse(quantityController.text) ?? 0.0;
    double unitPrice = double.tryParse(unitPriceController.text) ?? 0.0;
    return quantity * unitPrice;
  }

  double calculateTaxAmount() {
    double taxRate = double.tryParse(taxRateController.text) ?? 0.0;
    double subtotal = calculateSubtotal();
    return (taxRate / 100) * subtotal;
  }

  double calculateTotalAmount() {
    double subtotal = calculateSubtotal();
    double taxAmount = calculateTaxAmount();
    double discount = double.tryParse(discountController.text) ?? 0.0;
    return subtotal + taxAmount - discount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Billing Information'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: customerNameController,
              decoration: InputDecoration(labelText: 'Customer Name'),
            ),
            TextFormField(
              controller: customerAddressController,
              decoration: InputDecoration(labelText: 'Customer Address'),
            ),
            TextFormField(
              controller: customerContactController,
              decoration: InputDecoration(labelText: 'Customer Contact'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Invoice/Receipt Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: invoiceNumberController,
              decoration: InputDecoration(labelText: 'Invoice/Receipt Number'),
            ),
TextFormField(
  controller: dateController,
  decoration: InputDecoration(
    labelText: 'Date',
    prefixIcon: Icon(Icons.date_range),
  ),
  onTap: () async {
    final currentDate = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      final selectedDateTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(currentDate),
      );
      if (selectedDateTime != null) {
        setState(() {
          final dateTime = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedDateTime.hour,
            selectedDateTime.minute,
          );
          dateController.text = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
        });
      }
    }
  },
),
TextFormField(
  controller: dueDateController,
  decoration: InputDecoration(
    labelText: 'Due Date',
    prefixIcon: Icon(Icons.date_range),
  ),
  onTap: () async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100), // Set a distant future date
    );
    if (selectedDate != null) {
      setState(() {
        dueDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  },
),

            TextFormField(
              controller: paymentTermsController,
              decoration: InputDecoration(labelText: 'Payment Terms'),
            ),
            TextFormField(
              controller: paymentMethodController,
              decoration: InputDecoration(labelText: 'Payment Method'),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Itemized List',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: itemDescriptionController,
                    decoration: InputDecoration(labelText: 'Item Description'),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: quantityController,
                    decoration: InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {}); // Update the subtotal and total amount
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: unitPriceController,
                    decoration: InputDecoration(labelText: 'Unit Price'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {}); // Update the subtotal and total amount
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Subtotal: \$${calculateSubtotal().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Taxes and Discounts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: taxRateController,
              decoration: InputDecoration(labelText: 'Tax Rate'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {}); // Update the total amount
              },
            ),
            TextFormField(
              controller: discountController,
              decoration: InputDecoration(labelText: 'Discount'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {}); // Update the total amount
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Total Amount: \$${calculateTotalAmount().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _generateBill,
              child: Text('Generate Invoice/Receipt'),
            ),
          ],
        ),
      ),
    );
  }
}
