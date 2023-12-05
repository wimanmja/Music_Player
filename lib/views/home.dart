import 'package:flutter/material.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/views/myAppBar.dart';
import 'package:music_player/views/songlist.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: myAppBar(),
      body: SongList(),
    );
  }
}