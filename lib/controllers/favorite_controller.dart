import 'package:get/get.dart';
import '../controllers/player_controller.dart';

class FavoriteController extends GetxController {
  final PlayerController playerController = Get.find<PlayerController>();

  void addToFavorites(String songName) {
    playerController.addToFavorites(songName);
  }

  void removeFromFavorites(String songName) {
    playerController.removeFromFavorites(songName);
  }

  List<String> get favoriteSongs => playerController.favoriteSongs;
}