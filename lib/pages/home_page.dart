import 'package:flutter/material.dart';
import '../components/item_player_card.dart';
import '../models/cart_item.dart';
import '../data/models/player_card.dart';
import '../data/services/api_service.dart';
import '../pages/add_player_page.dart';


class HomePage extends StatefulWidget {
  final List<CartItem> cartItems;

  const HomePage({super.key, required this.cartItems});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PlayerCard> playerCards = [];
  List<CartItem> cartItems = [];

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadCards();
    cartItems = widget.cartItems;
  }

  Future<void> _loadCards() async {
    try {
      List<PlayerCard> cards = await apiService.getCards();
      setState(() {
        playerCards = cards;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка загрузки карточек: $e')),
      );
    }
  }

  void _addNewPlayerCard(PlayerCard playerCard) {
    setState(() {
      int currentPlayerId = playerCards[playerCards.length - 1].playerCardId;
      playerCard.playerCardId = currentPlayerId++;
      playerCards.add(playerCard);
    });
  }

  void _toggleFavorite(int playerCardId) {
    setState(() {
      final PlayerCard card =
          playerCards.firstWhere((card) => card.playerCardId == playerCardId);
      card.isFavorite = !card.isFavorite;
    });
  }

  void _deletePlayerCard(int index) {
    setState(() {
      playerCards.removeAt(index);
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
          fontSize: 32,
        ),
        title: const Center(
          child: Text('Карточки футболистов'),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: playerCards.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: ValueKey(playerCards[index].playerCardId),
            onDismissed: (direction) {
              _deletePlayerCard(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        'Футболист ${playerCards[index].footballerName} был удалён')),
              );
            },
            child: ItemPlayerCard(
              playerCard: playerCards[index],
              onDelete: (id) => setState(() {
                playerCards.removeWhere((card) => card.playerCardId == id);
              }),
              onToggleFavorite: () =>
                  _toggleFavorite(playerCards[index].playerCardId),
              onAddToCart: () => _addToCart(playerCards[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPlayerPage(onSubmit: _addNewPlayerCard),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
