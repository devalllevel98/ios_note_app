import 'dart:developer' as dev;
import 'dart:math';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:noteapp/config/card_colors.dart';
import 'package:noteapp/models/note_model.dart';

class DbService {
  DbService._();
  static final DbService _instance = DbService._();
  factory DbService() => _instance;

  var storage = Hive.box<NoteModel>("notes");

  List<NoteModel> getNotesFromStorage() {
    List<NoteModel>? notes = storage.keys.map((e) {
      var item = storage.get(e)!;
      return NoteModel(
        id: item.id,
        title: item.title,
        content: item.content,
        time: item.time,
        isFavorite: item.isFavorite,
        categories: item.categories,
        color: item.color,
      );
    }).toList();
    return notes;
  }

  Future<void> putNoteToStorage(int id, NoteModel data) async {
    try {
      await storage.put(id, data);
    } catch (e) {
      dev.log("$e");
    }
  }

  Future<void> deleteNoteFromStorage(int id) async {
    try {
      await storage.delete(id);
    } catch (e) {
      dev.log("$e");
    }
  }
}
