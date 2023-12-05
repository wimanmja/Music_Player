import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../const/colors.dart';
import '../const/icons.dart';
import '../const/text_style.dart';
import 'favorite.dart';

myAppBar() {
  return AppBar(
    backgroundColor: bgDarkColor,
    actions: [
      IconButton(
          onPressed: (){
            Get.to(Favorite());
          }, icon: favIcon())
    ],
    leading: Icon(Icons.multitrack_audio_rounded, color: whiteColor),
    title: Text(
        'My Music',
        style: myStyle(
          family: 'bold',
          size: 18,
        )
    ),
  );
}