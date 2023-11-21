import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/config/card_colors.dart';
import 'package:noteapp/models/note_model.dart';
import 'package:noteapp/utils/services/db_service.dart';

class AddController extends GetxController {
  DbService db = DbService();
  Rx<TextEditingController> titleController = Rx(TextEditingController());
  Rx<TextEditingController> contentController = Rx(TextEditingController());
  RxBool isRead = RxBool(false);
  RxBool isEdit = RxBool(false);
  Rx<int?> id = Rx(null);
  RxBool isFavorite = RxBool(false);
  Rx<NoteModel?> note = Rx(null);

  @override
  void onInit() {
    var oopData = Get.arguments;
    if (oopData == null) return;
    id.value = oopData['id'];
    isEdit.value = true;
    isRead.value = true;
    note.value = oopData['data'];
    note.refresh();
    isFavorite.value = note.value!.isFavorite!;
    titleController.value.text = note.value!.title;
    contentController.value.text = note.value!.content;
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    titleController.close();
    contentController.close();
  }

  void save() async {
    int id = isEdit.value ? note.value!.id : db.storage.length + 1;
    int color = isEdit.value
        ? note.value!.color!
        : AppColors
            .tileColors[Random().nextInt(AppColors.tileColors.length)].value;
    final data = NoteModel(
      id: id,
      title: titleController.value.text.trim(),
      content: contentController.value.text.trim(),
      isFavorite: isFavorite.value,
      color: color,
      time: DateTime.now().toString(),
    );
    await putNote(id, data);
    Get.back();
  }

  Future<void> putNote(int id, NoteModel data) async {
    await db.putNoteToStorage(id, data);
  }
}
