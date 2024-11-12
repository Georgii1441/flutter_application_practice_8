class CartItem {
  final int id;
  final String footballerName;
  final String photoUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.footballerName,
    required this.photoUrl,
    this.quantity = 1,
  });
}
