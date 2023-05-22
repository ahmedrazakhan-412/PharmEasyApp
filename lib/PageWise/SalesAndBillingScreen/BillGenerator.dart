import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class BillGenerator {
  void generateBill({
    required BuildContext context,
    required TextEditingController customerNameController,
    required TextEditingController customerAddressController,
    required TextEditingController customerContactController,
    required TextEditingController invoiceNumberController,
    required TextEditingController dateController,
    required TextEditingController dueDateController,
    required TextEditingController paymentTermsController,
    required TextEditingController paymentMethodController,
    required TextEditingController descriptionController,
    required TextEditingController itemDescriptionController,
    required TextEditingController quantityController,
    required TextEditingController unitPriceController,
    required TextEditingController taxRateController,
    required TextEditingController discountController,
    required double Function() calculateSubtotal,
    required double Function() calculateTotalAmount,
  }) {
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
                Text('Invoice/Receipt Number: ${invoiceNumberController.text}'),
                Text('Customer Name: ${customerNameController.text}'),
                //Text('Customer Address: ${customerAddressController.text}'),
                Text('Customer Contact: ${customerContactController.text}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date: ${dateController.text}'),
                    SizedBox(width: 5),
                    Text('Due Date: ${dueDateController.text}'),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                          width: 80,
                          child: Text('Item Description: \n${itemDescriptionController.text}')),
                    ),
                    Text('Unit Price: \n${unitPriceController.text}'),
                    Text('Quantity: \n${quantityController.text}'),

                  ],
                ),


                // Text('Payment Terms: ${paymentTermsController.text}'),
                Text('Payment Method: ${paymentMethodController.text}'),
                Text('Description: ${descriptionController.text}'),
                Text('Tax Rate: \Rs ${taxRateController.text}'),
                Text('Discount: \Rs ${discountController.text}'),
                SizedBox(height: 10),
                Text('Subtotal: \Rs ${calculateSubtotal().toStringAsFixed(2)}'),
                SizedBox(height: 10),
                Text(
                  'Total Amount: \Rs ${calculateTotalAmount().toStringAsFixed(
                      2)}',
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
                  saveBillToFile(
                      customerNameController: customerNameController);
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

  void saveBillToFile({
    required TextEditingController customerNameController,
  }) async {
    final String customerName = customerNameController.text;
    final String formattedDateTime =
    DateTime.now().toString().replaceAll(RegExp(r'[\s:-]'), '');
    final String fileName = '$customerName-$formattedDateTime.txt';
    final directory = await getApplicationDocumentsDirectory();
    final String folderPath = directory.path;
    final String filePath = path.join(folderPath, fileName);
    final String billContent = generateBillContent(
      customerNameController: customerNameController,
      formattedDateTime: formattedDateTime,
    );

    try {
      final file = File(filePath);
      await file.writeAsString(billContent);

      print('Bill saved to $filePath');
    } catch (e) {
      print('Error saving the bill: $e');
    }
  }


  String generateBillContent({
    required TextEditingController customerNameController,
    required String formattedDateTime,
  }) {
    String customerName = customerNameController.text;

    String billContent = '';
    billContent += 'Customer Name: $customerName\n';
    billContent += 'Date and Time: $formattedDateTime\n';
    // ... add other data ...

    return billContent;
  }
}