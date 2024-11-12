import 'package:flutter/material.dart';
import '../components/item_cart_card.dart';
import '../models/cart_item.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<CartItem> cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = widget.cartItems;
  }

  int get totalQuantity {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  void _increaseQuantity(int id) {
    setState(() {
      final item = cartItems.firstWhere((item) => item.id == id);
      item.quantity += 1;
    });
  }

  void _decreaseQuantity(int id) {
    setState(() {
      final item = cartItems.firstWhere((item) => item.id == id);
      if (item.quantity > 1) {
        item.quantity -= 1;
      } else {
        cartItems.removeWhere((item) => item.id == id);
      }
    });
  }

  void _removeCartItem(int id) {
    setState(() {
      cartItems.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 35, 126),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 152, 0),
          fontSize: 32,
        ),
        title: const Center(
          child: Text('Корзина'),
        ),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Ваша корзина пуста',
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 26, 35, 126)),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (cartItems.isNotEmpty) {
                          return Dismissible(
                            key: ValueKey(cartItems[index].id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.red,
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (direction) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Футболист ${cartItems[index].footballerName} был удалён из корзины')),
                              );
                              _removeCartItem(cartItems[index].id);
                            },
                            child: CartItemCard(
                              item: cartItems[index],
                              onIncrease: () =>
                                  _increaseQuantity(cartItems[index].id),
                              onDecrease: () =>
                                  _decreaseQuantity(cartItems[index].id),
                            ),
                          );
                        }
                        return Container();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Общее количество:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$totalQuantity',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
