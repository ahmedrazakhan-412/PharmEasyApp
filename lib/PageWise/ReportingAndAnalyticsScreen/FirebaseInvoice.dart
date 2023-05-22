import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHandler {
  static Future<void> storeInvoiceData(Map<String, dynamic> invoiceData) async {
    try {
      CollectionReference invoicesCollection =
      FirebaseFirestore.instance.collection('InvoiceData');
      await invoicesCollection.add(invoiceData);
      print('Invoice data stored successfully');
    } catch (e) {
      print('Error storing invoice data: $e');
    }
  }

  static Future<List<Object?>> getAllInvoiceData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('InvoiceData')
          .get();

      List<Object?> invoiceDataList = querySnapshot.docs
          .map((documentSnapshot) => documentSnapshot.data())
          .toList();

      return invoiceDataList;
    } catch (e) {
      print('Error retrieving invoice data: $e');
      return [];
    }
  }
}
