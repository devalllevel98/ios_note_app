import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dashboard/screens/notes_screen.dart';
import '../../dashboard/screens/favorites_screen.dart';

class IndexController extends GetxController {
  RxInt currentPage = RxInt(0);
  Rx<PageController> pageController =
      Rx(PageController(initialPage: 0, keepPage: true));

  RxList<StatelessWidget> pages = RxList([
    const NotesScreen(),
    const FavoritesScreen(),
  ]);

  toNotes() {
    if (currentPage.value == 0) return;
    pageController.value.animateToPage(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  toFavorites() {
    if (currentPage.value == 1) return;
    pageController.value.animateToPage(
      1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}
