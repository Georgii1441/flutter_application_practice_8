import 'package:flutter/material.dart';
import '../data/models/player_card.dart';

class PlayerPage extends StatelessWidget {
  final PlayerCard playerCard;
  final Function(int) onDelete;

  const PlayerPage(
      {super.key, required this.playerCard, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 35, 126),
        title: Text(playerCard.footballerName),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 152, 0),
          fontSize: 32,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              onDelete(playerCard.playerCardId);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Футболист был удалён',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 152, 0),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                playerCard.photoUrl,
                height: 300,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                playerCard.footballerName,
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 33, 33, 33)),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              playerCard.description,
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 26, 35, 126),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
