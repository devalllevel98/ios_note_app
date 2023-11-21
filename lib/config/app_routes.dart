import 'package:get/get.dart';
import 'package:noteapp/features/dashboard/bindings/favorites_binding.dart';
import 'package:noteapp/features/dashboard/bindings/home_binding.dart';
import 'package:noteapp/features/add/bindings/add_binding.dart';
import 'package:noteapp/features/index/bindings/index_binding.dart';
import 'package:noteapp/features/dashboard/screens/notes_screen.dart';
import 'package:noteapp/features/add/screens/add_screen.dart';
import 'package:noteapp/features/dashboard/screens/favorites_screen.dart';
import 'package:noteapp/features/index/screens/index_screen.dart';

class AppRoutes {
  static const initial = "/";
  static const add = "/add";
  static const notes = "/notes";
  static const favorites = "/favorites";

  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => const IndexScreen(),
      bindings: [
        IndexBinding(),
        NotesBinding(),
        FavoritesBinding(),
      ],
    ),
    GetPage(
      name: add,
      page: () => const AddScreen(),
      binding: AddBinding(),
    ),
    GetPage(
      name: notes,
      page: () => const NotesScreen(),
      binding: NotesBinding(),
    ),
    GetPage(
      name: favorites,
      page: () => const FavoritesScreen(),
      binding: FavoritesBinding(),
    ),
  ];
}
