import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Профиль'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Чернецов Ярослав ',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
    );
  }
}
