import 'package:flutter/material.dart';
import '../components/item_player_card.dart';
import '../data/models/player_card.dart';
import '../models/cart_item.dart';

class FavoritesPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const FavoritesPage({super.key, required this.cartItems});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<PlayerCard> playerCards = [];
  List<CartItem> cartItems = [];
  List<PlayerCard> favoriteCards = [];

  @override
  void initState() {
    super.initState();
    favoriteCards = playerCards.where((card) => card.isFavorite).toList();
    cartItems = widget.cartItems;
  }

  void _toggleFavorite(int playerCardId) {
    setState(() {
      final PlayerCard card =
          playerCards.firstWhere((card) => card.playerCardId == playerCardId);

      bool isFavoriteCard = card.isFavorite;
      card.isFavorite = !isFavoriteCard;

      if (isFavoriteCard) {
        favoriteCards.removeWhere((card) => card.playerCardId == playerCardId);
      }
    });
  }

  void _addToCart(PlayerCard playerCard) {
    final bool isItemExists =
        cartItems.any((item) => item.id == playerCard.playerCardId);

    if (isItemExists) {
      cartItems
          .firstWhere((item) => item.id == playerCard.playerCardId)
          .quantity += 1;
    } else {
      cartItems.add(CartItem(
        id: playerCard.playerCardId,
        footballerName: playerCard.footballerName,
        photoUrl: playerCard.photoUrl,
        quantity: 1,
      ));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('${playerCard.footballerName} добавлен в корзину')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 35, 126),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 152, 0),
          fontSize: 20,
        ),
        title: const Center(
          child: Text('Избранные карточки футболистов'),
        ),
      ),
      body: favoriteCards.isEmpty
          ? const Center(
              child: Text(
                'В избранном нет футболистов',
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 26, 35, 126)),
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: favoriteCards.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(favoriteCards[index].playerCardId.toString()),
                  onDismissed: (direction) {
                    _toggleFavorite(favoriteCards[index].playerCardId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Футболист ${favoriteCards[index].footballerName} был удалён из избранного')),
                    );
                  },
                  child: ItemPlayerCard(
                    playerCard: favoriteCards[index],
                    onDelete: (int id) => {
                      setState(() {
                        favoriteCards
                            .removeWhere((card) => card.playerCardId == id);
                        playerCards
                            .removeWhere((card) => card.playerCardId == id);
                      })
                    },
                    onToggleFavorite: () =>
                        _toggleFavorite(favoriteCards[index].playerCardId),
                    onAddToCart: () => _addToCart(favoriteCards[index]),
                  ),
                );
              },
            ),
    );
  }
}
