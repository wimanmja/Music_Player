import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/text_style.dart';
import '../controllers/favorite_controller.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        title: Text(
          'Favorites',
          style: myStyle(
            family: 'bold',
            size: 18,
          ),
        ),
      ),
      body: Obx(
            () => favoriteController.playerController.favoriteSongs.isEmpty
            ? Center(
          child: Text(
            "No Favorites Yet",
            style: myStyle(),
          ),
        )
            : ListView.builder(
          itemCount: favoriteController.playerController.favoriteSongs.length,
          itemBuilder: (context, index) {
            return ListTile(
              tileColor: bgColor,
              title: Text(
                favoriteController.playerController.favoriteSongs[index],
                style: myStyle(family: bold, size: 15),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: whiteColor),
                onPressed: () {
                  favoriteController.removeFromFavorites(
                      favoriteController.playerController.favoriteSongs[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
