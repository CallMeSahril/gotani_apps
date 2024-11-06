class CartItem {
  String imageUrl;
  String name;
  int price;
  int quantity;
  bool isSelected;

  CartItem({
    required this.imageUrl,
    required this.name,
    required this.price,
    this.quantity = 1,
    this.isSelected = false,
  });
}
