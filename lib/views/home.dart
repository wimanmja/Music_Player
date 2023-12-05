import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/text_style.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/views/myAppBar.dart';
import 'package:music_player/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: myAppBar(),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL
        ),
        builder: (BuildContext context, snapshot) {
          if(snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(snapshot.data!.isEmpty) {
            print(snapshot.data);
            return Center(
              child: Text(
                "No Song Found",
                style: myStyle(),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 3),
                    child: Obx(
                      () => ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor: bgColor,
                        title: Text(
                          snapshot.data![index].displayNameWOExt,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: myStyle(family: bold, size: 15),
                        ),
                        subtitle: Text(
                          '${snapshot.data![index].artist}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: myStyle(family: regular, size: 12),
                        ),
                        leading: QueryArtworkWidget(
                          id: snapshot.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Icon(
                            Icons.music_note,
                            color: whiteColor,
                            size: 32,
                          ),
                        ),
                        trailing: controller.playIndex.value == index && controller.isPlaying.value
                          ? const Icon(Icons.play_arrow, color: whiteColor, size: 36)
                          : null,
                        onTap: () {
                          Get.to(
                            () => Player(
                              data: snapshot.data!
                            ),
                            transition: Transition.downToUp,
                          );
                          controller.playSong(snapshot.data![index].uri, index);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}