import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../providers/game_provider.dart';
import '../screens/game_detail_screen.dart';

class GameCard extends StatelessWidget {
  final Game game;

  GameCard({required this.game});

  void _toggleFavorite(BuildContext context) {
    Provider.of<GameProvider>(context, listen: false).toggleFavorite(game.id);
  }

  void _navigateToDetail(BuildContext context) {
    Navigator.of(context).pushNamed(
      GameDetailScreen.routeName,
      arguments: game.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  game.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${game.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                game.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: game.isFavorite ? Colors.red : Colors.black,
              ),
              onPressed: () => _toggleFavorite(context),
            ),
          ],
        ),
      ),
    );
  }
}
