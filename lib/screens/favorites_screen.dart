import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/game_card.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteGames = Provider.of<GameProvider>(context).favoriteGames;
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранное'),
        backgroundColor: Colors.white,
      ),
      body: favoriteGames.isEmpty
          ? Center(
              child: Text(
                'Нет избранных игр',
                style: TextStyle(color: Colors.white),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: favoriteGames.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (ctx, index) =>
                    GameCard(game: favoriteGames[index]),
              ),
            ),
    );
  }
}
