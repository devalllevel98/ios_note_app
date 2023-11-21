import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/config/app_routes.dart';
import 'package:noteapp/features/dashboard/controllers/favorites_controller.dart';
import 'package:noteapp/shared_components/note_tile.dart';

class FavoritesScreen extends GetView<FavoritesController> {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.data.isEmpty) {
          return const Center(
            child: Text(
              "Add your content plan first favorite!",
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
              child: NoteTile(
                value: data,
                onTapFavorite: () =>
                    controller.updateFavorite(data.isFavorite!, index),
              ),
            );
          },
        );
      },
    );
  }
}
