import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../models/note_model.dart';
import '../../../utils/services/db_service.dart';

class FavoritesController extends GetxController {
  final db = DbService();
  RxList<NoteModel> data = RxList.empty();

  @override
  void onInit() async {
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
    return notes.where((element) => element.isFavorite == true).toList();
  }

  Future putNote(int id, NoteModel data) async {
    await db.putNoteToStorage(id, data);
  }
}
