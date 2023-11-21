import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/features/add/controllers/add_controller.dart';
import 'package:noteapp/utils/helpers/helpers.dart';

class AddScreen extends GetView<AddController> {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.keyboard_arrow_left_rounded),
            ),
            actions: controller.isRead.value
                ? [
                    IconButton(
                      onPressed: () =>
                          controller.isRead.value = !controller.isRead.value,
                      icon: const Icon(Icons.edit),
                    ),
                    const SizedBox(width: 8.0),
                  ]
                : [
                    IconButton(
                      onPressed: () => controller.isFavorite.value =
                          !controller.isFavorite.value,
                      icon: Icon(
                        controller.isFavorite.value
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: controller.isFavorite.value
                            ? Colors.red[700]
                            : null,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    SizedBox(
                      width: 70,
                      child: TextButton(
                        onPressed: () {
                          if (controller
                                  .titleController.value.text.isEmpty &&
                              controller
                                  .contentController.value.text.isEmpty) return;
                            controller.save();
                        },
                        child: const Text("Save"),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                      
                    ),
                  ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: controller.titleController.value,
                    readOnly: controller.isRead.value ? true : false,
                    maxLines: null,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(.7),
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                  const Divider(),
                  TextFormField(
                    controller: controller.contentController.value,
                    readOnly: controller.isRead.value ? true : false,
                    maxLines: null,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Type something...",
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(.7),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
