import 'package:flutter/material.dart';
import 'package:cat_app/models/cat.dart';
import 'package:cat_app/screens/cat_detail_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favorites';

  @override
  Widget build(BuildContext context) {
    final Box<Cat> favoritesBox = Hive.box<Cat>('favorites');

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ValueListenableBuilder(
        valueListenable: favoritesBox.listenable(),
        builder: (context, Box<Cat> box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text('No favorites yet'));
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final cat = box.getAt(index);
                return ListTile(
                  leading: Image.network(cat!.url),
                  title: Text(cat.id),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CatDetailScreen.routeName,
                      arguments: cat,
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      box.delete(cat.id);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
