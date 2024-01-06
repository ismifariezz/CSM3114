import 'package:campus_apps/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../models/item_model.dart'; // Import the Item class

class ReceiptScreen extends StatefulWidget {
  final double totalPayment;
  final List<Item> selectedItems;
  final int? numbOrder;

  ReceiptScreen({
    required this.totalPayment,
    required this.selectedItems,
    required this.numbOrder,
  });

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Receipt'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            Text(
              'Order Number: ${widget.numbOrder}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Total Payment: \RM${widget.totalPayment.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 16),
            Text(
              'Items in Cart:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8),
            Divider(
              thickness: 3,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.selectedItems.length,
                itemBuilder: (context, index) {
                  Item item = widget.selectedItems[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('\RM${item.price.toStringAsFixed(2)}'),
                    trailing: Text("x ${item.quantity}"),
                    // Add more details as needed
                  );
                },
              ),
            ),
            Divider(
              thickness: 3,
            ),
            GestureDetector(
              onTap: () {
                widget.selectedItems.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              child: Container(
                color: Colors.blue,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New Order',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
