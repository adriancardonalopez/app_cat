import 'package:flutter/material.dart';
import 'package:cat_app/models/cat.dart';
import 'package:cat_app/services/api_service.dart';
import 'package:cat_app/screens/favorites_screen.dart';
import 'package:cat_app/screens/cat_detail_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CatAdapter());
  await Hive.openBox<Cat>('favorites');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CatListScreen(),
      routes: {
        FavoritesScreen.routeName: (context) => FavoritesScreen(),
        CatDetailScreen.routeName: (context) => CatDetailScreen(),
      },
    );
  }
}

class CatListScreen extends StatefulWidget {
  @override
  _CatListScreenState createState() => _CatListScreenState();
}

class _CatListScreenState extends State<CatListScreen> {
  late Future<List<Cat>> futureCats;

  @override
  void initState() {
    super.initState();
    futureCats = ApiService().fetchCats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cats'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, FavoritesScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Cat>>(
        future: futureCats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No cats found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final cat = snapshot.data![index];
                return ListTile(
                  leading: Image.network(cat.url),
                  title: Text(cat.id),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CatDetailScreen.routeName,
                      arguments: cat,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

