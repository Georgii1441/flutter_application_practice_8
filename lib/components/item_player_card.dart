import 'package:flutter/material.dart';
import '../data/models/player_card.dart';
import '../pages/player_page.dart';

class ItemPlayerCard extends StatelessWidget {
  final PlayerCard playerCard;
  final Function(int) onDelete;
  final VoidCallback onToggleFavorite;
  final VoidCallback onAddToCart;

  const ItemPlayerCard({
    super.key,
    required this.playerCard,
    required this.onDelete,
    required this.onToggleFavorite,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PlayerPage(playerCard: playerCard, onDelete: onDelete),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 152, 0),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: const Color.fromARGB(255, 134, 80, 0),
              width: 3.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    playerCard.photoUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  playerCard.footballerName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 33, 33, 33),
                  ),
                  maxLines: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        playerCard.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: const Color.fromARGB(255, 26, 35, 126),
                      ),
                      onPressed: onToggleFavorite,
                    ),
                    IconButton(
                      icon: const Icon(Icons.shopping_cart_outlined,
                          color: Color.fromARGB(255, 26, 35, 126)),
                      onPressed: onAddToCart,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
