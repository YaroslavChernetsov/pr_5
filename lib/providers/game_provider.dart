import 'package:flutter/material.dart';
import '../models/game.dart';

class GameProvider with ChangeNotifier {
  List<Game> _games = [
    Game(
      id: '1',
      title: 'Dark sols 3',
      imageUrl:
          'https://cdn.kanobu.ru/c/172ee9041f9e939f571d7f4a0a7ebd8b/400x510/cdn.kanobu.ru/games/85c39c41-5056-4744-8735-db51c091a21f.jpg',
      price: 20,
      description: 'грусть ',
    ),
    Game(
        id: "2",
        title: "Doom",
        imageUrl:
            "https://img.championat.com/s/1350x900/news/big/b/q/pjat-krutyh-shuterov-90-h-godov_15632801891100895569.jpg",
        price: 10,
        description: "shoter"),
  ];

  List<Game> get games => [..._games];

  List<Game> get favoriteGames =>
      _games.where((game) => game.isFavorite).toList();

  void addGame(Game game) {
    _games.add(game);
    notifyListeners();
  }

  void removeGame(String id) {
    _games.removeWhere((game) => game.id == id);
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final index = _games.indexWhere((game) => game.id == id);
    if (index >= 0) {
      _games[index].isFavorite = !_games[index].isFavorite;
      notifyListeners();
    }
  }
}
