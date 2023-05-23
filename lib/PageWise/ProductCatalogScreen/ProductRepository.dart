import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository {
  static Future<void> storeProduct(Map<String, dynamic> product) async {
    try {
      CollectionReference productsCollection =
          FirebaseFirestore.instance.collection('Product');
      await productsCollection.add(product);
      print('Product data stored successfully');
    } catch (e) {
      print('Error storing product data: $e');
    }
  }

  static Future<List<Object?>> getAllInvoiceData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Product')
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