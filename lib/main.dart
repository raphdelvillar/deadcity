import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:deadcity/game.dart';

void main() async {
  Flame.audio.disableLog();
  Flame.audio.loadAll(<String>[
    "sfx/fire1.mp3",
    "sfx/fire2.mp3",
    "sfx/fire3.mp3",
    "sfx/survivor_death1.mp3",
    "sfx/survivor_death2.mp3"
  ]);

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  DeadCityGame game = DeadCityGame();
  runApp(game.widget);
}