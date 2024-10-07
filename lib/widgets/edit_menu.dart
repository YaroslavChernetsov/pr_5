import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/game_provider.dart';
import '../models/game.dart';

class EditMenu extends StatefulWidget {
  @override
  _EditMenuState createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _imageUrl = '';
  String _price = '';
  String _description = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newGame = Game(
        id: Uuid().v4(),
        title: _title,
        imageUrl: _imageUrl,
        price: double.parse(_price),
        description: _description,
      );
      Provider.of<GameProvider>(context, listen: false).addGame(newGame);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final games = Provider.of<GameProvider>(context).games;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Добавить новую игру',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Название',
                      filled: true,
                      fillColor: Colors.black,
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите название';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _title = value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'URL изображения',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите URL изображения';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _imageUrl = value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Цена',
                      filled: true,
                      fillColor: Colors.black,
                    ),
                    style: TextStyle(color: Colors.black),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          double.tryParse(value) == null) {
                        return 'Введите корректную цену';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _price = value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Описание',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(color: Colors.black),
                    maxLines: 3,
                    onSaved: (value) {
                      _description = value ?? '';
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text('Добавить'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(color: Colors.black),
            SizedBox(height: 10),
            Text(
              'Удалить игру',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 10),
            ...games.map((game) => ListTile(
                  title: Text(
                    game.title,
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _confirmDelete(context, game.id);
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Подтвердите удаление'),
        content: Text('Вы уверены, что хотите удалить эту игру?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Отмена', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Provider.of<GameProvider>(context, listen: false).removeGame(id);
              Navigator.of(ctx).pop();
            },
            child: Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
        backgroundColor: Colors.grey[800],
      ),
    );
  }
}
