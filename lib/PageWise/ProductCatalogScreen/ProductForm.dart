import 'package:flutter/material.dart';
import 'Product.dart';
import 'ProductRepository.dart';

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _manufacturerController = TextEditingController();
  TextEditingController _activeIngredientController = TextEditingController();
  TextEditingController _dosageFormController = TextEditingController();
  TextEditingController _strengthController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _storageConditionsController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _prescriptionRequiredController = TextEditingController();
  TextEditingController _barcodeController = TextEditingController();

  Map<String, String> fieldDescriptions = {
    'Product Name': 'The name or brand name of the product.',
    'Description': 'A brief description or summary of the product.',
    'Quantity': 'The quantity or stock available for the product.',
    'Price': 'The price of the product.',
    'Manufacturer': 'The name of the pharmaceutical company or manufacturer.',
    'Active Ingredient': 'The active ingredient(s) present in the product.',
    'Dosage Form': 'The form in which the product is available (e.g., tablets, capsules, syrup, etc.).',
    'Strength': 'The strength or concentration of the active ingredient(s) in the product.',
    'Expiry Date': 'The date until which the product remains effective and safe to use.',
    'Storage Conditions': 'Recommended storage conditions for the product (e.g., temperature, humidity).',
    'Category': 'The category or therapeutic class of the product (e.g., analgesics, antibiotics, vitamins).',
    'Prescription Required': 'Indicates whether a prescription is required to purchase the product.',
    'Barcode': 'The unique barcode associated with the product for scanning and tracking purposes.',
    'Date Added': 'The date when the product was added to the database.',
    'Last Modified': 'The date and time when the product information was last modified.',
  };

  void _saveProduct() {
    Product product = Product(
      productName: _productNameController.text,
      description: _descriptionController.text,
      quantity: int.parse(_quantityController.text),
      price: double.parse(_priceController.text),
      manufacturer: _manufacturerController.text,
      activeIngredient: _activeIngredientController.text,
      dosageForm: _dosageFormController.text,
      strength: _strengthController.text,
      expiryDate: _expiryDateController.text,
      storageConditions: _storageConditionsController.text,
      category: _categoryController.text,
      prescriptionRequired: _prescriptionRequiredController.text == 'true',
      barcode: _barcodeController.text,
      dateAdded: DateTime.now().toString(),
      lastModified: DateTime.now().toString(),
    );

    ProductRepository.storeProduct(product.toMap());
  }

  void showInformationDialog(String fieldName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(fieldName),
          content: Text(fieldDescriptions[fieldName] ?? 'No information available.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
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
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFieldWithInfoIcon('Product Name'),
              SizedBox(height: 16.0),
              _buildFieldWithInfoIcon('Description'),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: _buildFieldWithInfoIcon('Quantity'),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: _buildFieldWithInfoIcon('Price'),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              _buildFieldWithInfoIcon('Manufacturer'),
              SizedBox(height: 16.0),
              _buildFieldWithInfoIcon('Active Ingredient'),
              SizedBox(height: 16.0),
              _buildFieldWithInfoIcon('Dosage Form'),
              SizedBox(height: 16.0),
              _buildFieldWithInfoIcon('Strength'),
              SizedBox(height: 16.0),
              _buildFieldWithInfoIcon('Expiry Date'),
              SizedBox(height: 16.0),
              _buildFieldWithInfoIcon('Storage Conditions'),
              SizedBox(height: 16.0),
              _buildFieldWithInfoIcon('Category'),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: _buildFieldWithInfoIcon('Prescription Required'),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: _buildFieldWithInfoIcon('Barcode'),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveProduct,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldWithInfoIcon(String fieldName) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: fieldName,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        IconButton(
          onPressed: () {
            showInformationDialog(fieldName);
          },
          icon: Icon(Icons.info),
        ),
      ],
    );
 }

}
