import 'package:flutter/material.dart';
import 'package:cat_app/models/cat.dart';
import 'package:hive/hive.dart';

class CatDetailScreen extends StatelessWidget {
  static const routeName = '/cat-detail';

  @override
  Widget build(BuildContext context) {
    final cat = ModalRoute.of(context)!.settings.arguments as Cat;
    final Box<Cat> favoritesBox = Hive.box<Cat>('favorites');

    return Scaffold(
      appBar: AppBar(
        title: Text(cat.id),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(cat.url),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                favoritesBox.put(cat.id, cat);
              },
              child: Text('Add to Favorites'),
            ),
          ],
        ),
      ),
    );
  }
}
