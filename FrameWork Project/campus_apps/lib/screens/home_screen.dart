import 'profile_screen.dart';
import 'package:flutter/material.dart';
import '../data/marketplace_data.dart';
import '../models/item_model.dart';
import 'payment_screen.dart'; // Import the PaymentScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> filteredItems = List.from(marketplaceItems);
  TextEditingController searchController = TextEditingController();
  double totalPayment = 0.0;
  List<Item> selectedItems = []; // Maintain a list of selected items
  int numbOrder = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Marketplace'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  filteredItems = marketplaceItems
                      .where((item) =>
                          item.name
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          item.description
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                Item item = filteredItems[index];
                return ListTile(
                  leading: Image.asset(item.imagePath),
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\RM${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            totalPayment += item.price;
                            if (!selectedItems.contains(item)) {
                              selectedItems.add(item);
                              item.quantity += 1;
                            } else {
                              item.quantity += 1;
                            }
                          });
                          _showSnackBar('Added ${item.name} to cart');
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              if (totalPayment == 0) {
                _showSnackBar('Select items before proceeding to payment');
              } else {
                setState(() {
                  numbOrder += 1; // Increment order number by 1
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                      totalPayment: totalPayment,
                      selectedItems: selectedItems,
                      numbOrder: numbOrder,
                    ),
                  ),
                );
              }
            },
            child: Container(
              color: Colors.red,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Payment: \RM${totalPayment.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(
                    Icons.payment,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const SizedBox(
              height: 60.0,
              child: const DrawerHeader(
                decoration: BoxDecoration(color: Colors.red),
                child: Text('Menu'),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ProfileScreen();
                  },
                ));
              },
              leading: Icon(
                Icons.person,
                color: Colors.red,
              ),
            ),
            ListTile(
              title: Text('History'),
              onTap: () {},
              leading: Icon(
                Icons.history,
                color: Colors.red,
              ),
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {},
              leading: Icon(Icons.settings, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
