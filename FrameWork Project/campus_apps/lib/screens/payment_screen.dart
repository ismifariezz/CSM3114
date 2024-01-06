import 'package:campus_apps/screens/Receipt_screen.dart';
import 'package:flutter/material.dart';
import '../models/item_model.dart'; // Import the Item class

class PaymentScreen extends StatelessWidget {
  final double totalPayment;
  final List<Item> selectedItems;
  final int numbOrder;

  PaymentScreen(
      {required this.totalPayment,
      required this.selectedItems,
      required this.numbOrder});

  void _showsInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Successfully!'),
          actions: [
            TextButton(
              child: Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Show Receipt'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReceiptScreen(
                      totalPayment: totalPayment,
                      selectedItems: selectedItems,
                      numbOrder: numbOrder,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Make Payment'),
          actions: [
            TextButton(
              child: Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Pay'),
              onPressed: () {
                Navigator.of(context).pop();
                Future.delayed(Duration.zero, () {
                  _showsInputDialog(context);
                });
              },
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
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Payment: \RM${totalPayment.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Items in Cart:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                Item item = selectedItems[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('\RM${item.price.toStringAsFixed(2)}'),
                  trailing: Text("${item.quantity}x"),
                  // Add more details as needed
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              _showsDialog(context);
            },
            child: Container(
              color: Colors.blue,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Make Payment : \RM${totalPayment.toStringAsFixed(2)}',
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
          )
        ],
      ),
    );
  }
}
