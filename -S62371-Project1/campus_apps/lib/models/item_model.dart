// models/item_model.dart

class Item {
  String imagePath;
  String name;
  String description;
  double price;
  int quantity; // Add the quantity property

  Item({
    required this.imagePath,
    required this.name,
    required this.description,
    required this.price,
    this.quantity = 0, // Default quantity to 1
  });

  Item.defaults()
      : imagePath = '',
        name = '',
        description = '',
        price = 0.0,
        quantity = 0;
}
