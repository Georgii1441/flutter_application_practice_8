class PlayerCard {
  late int playerCardId;
  final String footballerName;
  final String description;
  final String photoUrl;
  late bool isFavorite;

  PlayerCard({
    required this.playerCardId,
    required this.footballerName,
    required this.description,
    required this.photoUrl,
    this.isFavorite = false,
  });

  factory PlayerCard.fromJson(Map<String, dynamic> json) {
    return PlayerCard(
      playerCardId: json['playerCardId'],
      footballerName: json['footballerName'],
      description: json['description'],
      photoUrl: json['photoUrl'],
    );
  }
}
