import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicalstore/Login/UserProvider.dart';
import 'package:provider/provider.dart';
import 'DashboardModuleCard.dart';
import 'package:medicalstore/PageWise/UserRegistrationScreen/UserRegistrationScreen.dart';
import 'package:medicalstore/PageWise/ProductCatalogScreen/ProductCatalogScreen.dart';
import 'package:medicalstore/PageWise/InventoryManagementScreen/InventoryManagementScreen.dart';
import 'package:medicalstore/PageWise/SalesAndBillingScreen/SalesAndBillingScreen.dart';
import 'package:medicalstore/PageWise/OrderManagementScreen/OrderManagementScreen.dart';
import 'package:medicalstore/PageWise/CustomerManagementScreen/CustomerManagementScreen.dart';
import 'package:medicalstore/PageWise/PrescriptionManagementScreen/PrescriptionManagementScreen.dart';
import 'package:medicalstore/PageWise/ReportingAndAnalyticsScreen/ReportingAndAnalyticsScreen.dart';
import 'package:medicalstore/PageWise/AdministrationAndSecurityScreen/AdministrationAndSecurityScreen.dart';
import 'package:medicalstore/PageWise/PaymentGatewaysIntegration/PaymentGatewaysIntegration.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userName = Provider.of<UserProvider>(context).userName;
    String currentDate = DateFormat('MMM dd, yyyy').format(DateTime.now());
    String currentTime = DateFormat('hh:mm a').format(DateTime.now());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome, $userName',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                '$currentDate $currentTime',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.teal[600],
                    width: 200,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/images/profile.png'),
                              radius: 40,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 130,
                            height: 40,
                            child: Container(
                              width: 150,
                              height: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(onPressed: () {}, icon: Icon(Icons.person, color: Colors.white)),
                                  Text('My Cloud', style: TextStyle(fontSize: 12, color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 130,
                            height: 40,
                            child: Container(
                              width: 150,
                              height: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(onPressed: () {}, icon: Icon(Icons.people, color: Colors.white)),
                                  Text('Shared Files', style: TextStyle(fontSize: 12, color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 130,
                            height: 40,
                            child: Container(
                              width: 150,
                              height: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(onPressed: () {}, icon: Icon(Icons.star, color: Colors.white)),
                                  Text('Favorites', style: TextStyle(fontSize: 12, color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 130,
                            height: 40,
                            child: Container(
                              width: 150,
                              height: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(onPressed: () {}, icon: Icon(Icons.cloud_upload, color: Colors.white)),
                                  Text('Upload Files', style: TextStyle(fontSize: 12, color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 250,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Settings'),
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
                                  },
                                  icon: Icon(Icons.settings, color: Colors.white),
                                ),
                                Text(
                                  'Settings',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Are you sure you want to logout', style: TextStyle(fontSize: 12)),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.popUntil(context, (route) => route.isFirst);
                                              },
                                              child: Text('Yes'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('No'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.logout, color: Colors.white),
                                ),
                                Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Container(
                              height: 500,
                              width: 600,
                              child: Image.asset('assets/images/dashboard.jpg'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
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
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        child: Column(
                          children: [
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          ),
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
