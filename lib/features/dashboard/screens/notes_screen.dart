import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../../config/app_routes.dart';
import '../../../shared_components/note_tile.dart';
import '../controllers/notes_controller.dart';

class NotesScreen extends GetView<NotesController> {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.data.isEmpty) {
          return const Center(
            child: Text(
              "Write a plan content, pursue your goals.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: controller.data.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            var data = controller.data[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  AppRoutes.add,
                  arguments: {"id": data.id, "data": data},
                );
              },
              child: Slidable(
                key: ValueKey(data.id),
                startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  extentRatio: .3,
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        controller.deleteNote(data.id);
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete', 
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
                child: NoteTile(
                  value: data,
                  onTapFavorite: () =>
                      controller.updateFavorite(data.isFavorite!, index),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
