import 'package:flutter/material.dart';
import 'DashboardModuleCard.dart';
import 'ProductCatalogScreen.dart';
import 'UserRegistrationScreen.dart';
import 'InventoryManagementScreen.dart';
import 'SalesAndBillingScreen.dart';
import 'OrderManagementScreen.dart';
import 'CustomerManagementScreen.dart';
import 'PrescriptionManagementScreen.dart';
import 'ReportingAndAnalyticsScreen.dart';
import 'AdministrationAndSecurityScreen.dart';
import 'PaymentGatewaysIntegration.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(
    child:  Text('Medical Store Dashboard'),
      ),
      ),
      body: GridView.count(
        crossAxisCount: 8,
        padding: EdgeInsets.all(16.0),
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.7,
        children: <Widget>[
          _buildModuleCard(
            context,
            UserRegistrationScreen(),
            'User Registration',
            Icons.person_add,
          ),
          _buildModuleCard(
            context,
            ProductCatalogScreen(),
            'Product Catalog',
            Icons.shopping_basket,
          ),
          _buildModuleCard(
            context,
            InventoryManagementScreen(),
            'Inventory Management',
            Icons.storage,
          ),
          _buildModuleCard(
            context,
            SalesAndBillingScreen(),
            'Sales and Billing',
            Icons.receipt,
          ),
          _buildModuleCard(
            context,
            OrderManagementScreen(),
            'Order Management',
            Icons.shopping_cart,
          ),
          _buildModuleCard(
            context,
            CustomerManagementScreen(),
            'Customer Management',
            Icons.people,
          ),
          _buildModuleCard(
            context,
            PrescriptionManagementScreen(),
            'Prescription Management',
            Icons.description,
          ),
          _buildModuleCard(
            context,
            ReportingAndAnalyticsScreen(),
            'Reports',
            Icons.bar_chart,
          ),
          _buildModuleCard(
            context,
            AdministrationAndSecurityScreen(),
            'Administration',
            Icons.settings,
          ),
          _buildModuleCard(
            context,
            PaymentGatewaysIntegration(),
            'Payment',
            Icons.attach_money,
          ),
        ],
      ),
    );
  }

  Widget _buildModuleCard(
    BuildContext context,
    Widget destinationScreen,
    String moduleName,
    IconData iconData,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.withOpacity(0.5),
        highlightColor: Colors.blue.withOpacity(0.2),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationScreen),
          );
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: DashboardModuleCard(
            moduleName: moduleName,
            icon: iconData,
          ),
        ),
      ),
    );
  }
}
