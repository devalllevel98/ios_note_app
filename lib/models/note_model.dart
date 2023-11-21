import 'package:get/get.dart';
import 'package:hive/hive.dart';
part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel extends HiveObject {
  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    this.time,
    this.isFavorite,
    this.categories,
    this.color,
  });
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String content;
  @HiveField(3)
  String? time;
  @HiveField(4, defaultValue: false)
  bool? isFavorite;
  @HiveField(5, defaultValue: [])
  List<String>? categories;
  @HiveField(6)
  int? color;
  @override
  toString() {
    return "$id, $title, $content, $time, $isFavorite";
  }
}
