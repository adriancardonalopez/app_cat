import 'package:hive/hive.dart';

part 'cat.g.dart';

@HiveType(typeId: 0)
class Cat {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String url;

  Cat({required this.id, required this.url});

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      id: json['id'],
      url: json['url'],
    );
  }
}
