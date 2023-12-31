import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/icons.dart';
import 'package:music_player/const/text_style.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/player_controller.dart';
import '../controllers/favorite_controller.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    final FavoriteController favoriteController = Get.put(FavoriteController());

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        actions: [
          IconButton(
            onPressed: () {
              favoriteController.addToFavorites(data[controller.playIndex.value].displayNameWOExt);
            },
            icon: Obx(() {
              bool isFavorite = favoriteController.favoriteSongs.contains(data[controller.playIndex.value].displayNameWOExt);
              return favIcon(color: isFavorite ? Colors.red : whiteColor);
            }),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 350,
                  width: 350,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: QueryArtworkWidget(
                    id: data[controller.playIndex.value].id,
                    type: ArtworkType.AUDIO,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    nullArtworkWidget: const Icon(Icons.music_note, size: 48, color: whiteColor),
                  ),
                )
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15),
                  )
                ),
                child: Obx(
                  () => Column(
                    children: [
                      Text(
                        data[controller.playIndex.value].displayNameWOExt,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: myStyle(
                          color: bgDarkColor,
                          family: bold,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        data[controller.playIndex.value].artist.toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: myStyle(
                          color: bgColor,
                          family: regular,
                          size: 20,
                        ),
                      ),
                      SizedBox(height: 12),
                      Obx(
                        ()=> Row(
                          children: [
                            Text(
                              controller.position.value,
                              style: myStyle(color: bgDarkColor)
                            ),
                            Expanded(
                              child: Slider(
                                thumbColor: sliderColor,
                                inactiveColor: bgColor,
                                activeColor: sliderColor,
                                min: Duration(seconds: 0).inSeconds.toDouble(),
                                max: controller.max.value,
                                value: controller.value.value,
                                onChanged: (newValue){
                                  controller.changeDurationToSeconds(newValue.toInt());
                                  newValue = newValue;
                                }
                              )
                            ),
                            Text(
                              controller.duration.value,
                              style: myStyle(color: bgDarkColor)
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              int prevIndex = controller.playIndex.value - 1;
                              if(prevIndex < 0) {
                                prevIndex = data.length - 1;
                              }
                              controller.playSong(data[prevIndex].uri, prevIndex);
                            },
                            icon: Icon(
                              Icons.skip_previous_rounded,
                              size: 50,
                              color: bgDarkColor,
                            )
                          ),
                          Obx(
                            () => CircleAvatar(
                              radius: 35,
                              backgroundColor: bgDarkColor,
                              child: Transform.scale(
                                scale: 2.5,
                                child: IconButton(
                                  onPressed: () {
                                    if(controller.isPlaying.value) {
                                      controller.audioPlayer.pause();
                                      controller.isPlaying(false);
                                    } else {
                                      controller.audioPlayer.play();
                                      controller.isPlaying(true);
                                    }
                                  },
                                  icon: controller.isPlaying.value
                                  ? const Icon(
                                      Icons.pause,
                                      color: whiteColor,
                                    )
                                  : const Icon(
                                      Icons.play_arrow_rounded,
                                      color: whiteColor,
                                    ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              int nextIndex = controller.playIndex.value + 1;
                              if(nextIndex >= data.length) {
                                nextIndex = 0;
                              }
                              controller.playSong(data[nextIndex].uri, nextIndex);
                            },
                            icon: Icon(
                              Icons.skip_next_rounded,
                              size: 50,
                              color: bgDarkColor,
                            )
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}