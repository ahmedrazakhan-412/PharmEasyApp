import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicalstore/Dashboard/DashboardScreen.dart';


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
        return Expanded(
          child: AlertDialog(
            title: Text('Bill Generated'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Customer Name: ${customerNameController.text}'),
                //Text('Customer Address: ${customerAddressController.text}'),
                Text('Customer Contact: ${customerContactController.text}'),
                Text('Invoice/Receipt Number: ${invoiceNumberController.text}'),
                Text('Date: ${dateController.text}'),
                Text('Due Date: ${dueDateController.text}'),
               // Text('Payment Terms: ${paymentTermsController.text}'),
                Text('Payment Method: ${paymentMethodController.text}'),
                Text('Description: ${descriptionController.text}'),
                //Text('Item Description: \n${itemDescriptionController.text}'),
                Text('Quantity: \n${quantityController.text}'),
                Text('Unit Price: \n${unitPriceController.text}'),
                Text('Tax Rate: \Rs ${taxRateController.text}'),
                Text('Discount: \Rs ${discountController.text}'),
                SizedBox(height: 10),
                Text('Subtotal: \Rs ${calculateSubtotal().toStringAsFixed(2)}'),
                SizedBox(height: 10),
                Text(
                  'Total Amount: \Rs ${calculateTotalAmount().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  // Print option functionality
                  // Implement your printing logic here
                  print('Printing the bill...');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text('Print'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Save option functionality
                  // Implement your saving logic here
                  print('Saving the bill...');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text('Save'),
              ),
            ],
          ),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Customer Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 300,
                      height: 80,
                      child: TextFormField(
                        controller: customerNameController,
                        decoration: InputDecoration(labelText: 'Customer Name'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 40,
                ),
                Column(
                   children: [
                     SizedBox(
                       width: 200,
                       height: 80,
                       child: TextFormField(
                         controller: customerContactController,
                         decoration: InputDecoration(labelText: 'Customer Contact'),
                       ),
                     ),
                   ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 600,
                  child: TextFormField(
                    controller: customerAddressController,
                    decoration: InputDecoration(labelText: 'Customer Address'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.0),
            Row(
              children: [
                Text(
                  'Invoice/Receipt Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 80,
                      child: TextFormField(
                        controller: invoiceNumberController,
                        decoration: InputDecoration(labelText: 'Invoice/Receipt Number'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 40,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 80,
                      child:   TextFormField(
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
                    ),

                  ],
                ),
                SizedBox(
                  width: 40,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 80,
                      child:   TextFormField(
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
                    ),
                  ],
                ),
              ],
            ),
           Row(
             children: [
               Column(
                 children: [
                   SizedBox(height:80,
                     width: 200,
                     child: TextFormField(
                       controller: paymentTermsController,
                       decoration: InputDecoration(labelText: 'Payment Terms'),
                     ),
                   ),
                 ],
               ),
               SizedBox(
                 width: 40,
               ),
               Column(
                 children: [
                   SizedBox(
                     height: 80,
                     width: 200,
                     child: TextFormField(
                       controller: paymentMethodController,
                       decoration: InputDecoration(labelText: 'Payment Method'),
                     ),
                   ),
                 ],
               ),
               SizedBox(
                 width: 40,
               ),
               Column(
                 children: [
                   SizedBox(width: 200,
                     height: 80,
                     child: TextFormField(
                       controller: descriptionController,
                       decoration: InputDecoration(labelText: 'Description'),
                     ),
                   ),
                 ],
               ),
             ],
           ),
            SizedBox(height: 16.0),
            Text(
              'Itemized List',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 200,
                      child: TextFormField(
                        controller: itemDescriptionController,
                        decoration: InputDecoration(labelText: 'Item Description'),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 40),
                Column(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 80,
                      child: TextFormField(
                        controller: quantityController,
                        decoration: InputDecoration(labelText: 'Quantity'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {}); // Update the subtotal and total amount
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 40),
                Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 200,
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
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Subtotal : \Rs ${calculateSubtotal().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Taxes and Discounts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 80,
                      child: TextFormField(
                        controller: taxRateController,
                        decoration: InputDecoration(labelText: 'Tax Rate'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {}); // Update the total amount
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 40,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 200,
                      child: TextFormField(
                        controller: discountController,
                        decoration: InputDecoration(labelText: 'Discount'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {}); // Update the total amount
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                'Total Amount : \Rs ${calculateTotalAmount().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: SizedBox(
                width: 250,
                height: 40,
                child: ElevatedButton(
                  onPressed: _generateBill,
                  child: Text('Generate Invoice/Receipt'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
