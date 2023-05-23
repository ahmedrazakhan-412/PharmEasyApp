

class Product {
  String productName;
  String description;
  int quantity;
  double price;
  String manufacturer;
  String activeIngredient;
  String dosageForm;
  String strength;
  String expiryDate;
  String storageConditions;
  String category;
  bool prescriptionRequired;
  String barcode;
  String dateAdded;
  String lastModified;

  Product({
    required this.productName,
    required this.description,
    required this.quantity,
    required this.price,
    required this.manufacturer,
    required this.activeIngredient,
    required this.dosageForm,
    required this.strength,
    required this.expiryDate,
    required this.storageConditions,
    required this.category,
    required this.prescriptionRequired,
    required this.barcode,
    required this.dateAdded,
    required this.lastModified,
  });

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'description': description,
      'quantity': quantity,
      'price': price,
      'manufacturer': manufacturer,
      'activeIngredient': activeIngredient,
      'dosageForm': dosageForm,
      'strength': strength,
      'expiryDate': expiryDate,
      'storageConditions': storageConditions,
      'category': category,
      'prescriptionRequired': prescriptionRequired,
      'barcode': barcode,
      'dateAdded': dateAdded,
      'lastModified': lastModified,
    };
  }
}
