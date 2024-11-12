import 'package:dio/dio.dart';
import '../models/player_card.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<PlayerCard>> getCards() async {
    try {
      final response = await _dio.get('http://localhost:8080/cards');
      if (response.statusCode == 200) {
        List<PlayerCard> cards = (response.data as List)
            .map((cards) => PlayerCard.fromJson(cards))
            .toList();
        return cards;
      } else {
        throw Exception('Failed to load cards');
      }
    } catch (e) {
      throw Exception('Error fetching cards: $e');
    }
  }
}
