import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/models/note_model.dart';
import 'package:noteapp/utils/services/db_service.dart';

class NotesController extends GetxController {
  final db = DbService();
  RxList<NoteModel> data = RxList.empty();

  @override
  void onInit() async {
    if (data.isEmpty) {
      data.assignAll(getNotes());
    }
    streamStorage();
    super.onInit();
  }

  void streamStorage() {
    db.storage.listenable().addListener(() {
      data.assignAll(getNotes());
    });
  }

  Future updateFavorite(bool isFavorite, int index) async {
    data[index].isFavorite = !isFavorite;
    data.refresh();
    await putNote(data[index].id, data[index]);
  }

  List<NoteModel> getNotes() {
    List<NoteModel> notes = db.getNotesFromStorage();
    return notes;
  }

  Future putNote(int id, NoteModel data) async {
    await db.putNoteToStorage(id, data);
  }

  Future deleteNote(int id) async {
    await db.deleteNoteFromStorage(id);
  }
}
