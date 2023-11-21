import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:noteapp/config/app_routes.dart';
import 'package:noteapp/features/index/controllers/index_controller.dart';

class IndexScreen extends GetView<IndexController> {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(() {
        return Visibility(
          visible: controller.currentPage.value == 0,
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Get.toNamed(AppRoutes.add);
              Slidable.of(context)?.close();
            },
          ),
        );
      }),
      appBar: AppBar(
        flexibleSpace: Center(
          child: Obx(() {
            return Padding(padding: EdgeInsets.only(top: 20),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                      backgroundColor: controller.currentPage.value == 0
                        ? Color.fromARGB(255, 182, 245, 87)
                        : null,
                   ),
                  onPressed: () => controller.toNotes(),
                  icon: Icon(
                    MdiIcons.noteMultiple,
                    size: 22,
                    color:
                        controller.currentPage.value == 0 ? Colors.black : null,
                  ),
                ),
                SizedBox(
                  width: Get.width / 5,
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: controller.currentPage.value == 1
                        ? Color.fromARGB(255, 182, 245, 87)
                        : null,
                  ),
                  onPressed: () => controller.toFavorites(),
                  icon: Icon(
                    Icons.favorite,
                    color:
                        controller.currentPage.value == 1 ? Colors.black : null,
                  ),
                ),
              ],
            ),
            );
          }),
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: controller.pageController.value,
        onPageChanged: (i) => controller.currentPage.value = i,
        children: controller.pages,
      ),
    );
  }
}
