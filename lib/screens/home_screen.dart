import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/game_card.dart';
import '../widgets/edit_menu.dart';

class HomeScreen extends StatelessWidget {
  void _showEditMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return EditMenu();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final games = Provider.of<GameProvider>(context).games;
    return Scaffold(
      appBar: AppBar(
        title: Text('MegaEpic Store'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _showEditMenu(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: games.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, index) => GameCard(game: games[index]),
        ),
      ),
    );
  }
}
