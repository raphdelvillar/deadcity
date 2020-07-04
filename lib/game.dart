import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:deadcity/components/city.dart';
import 'package:deadcity/components/zombie.dart';
import 'package:deadcity/components/survivor.dart';

class DeadCityGame extends Game {
  Size screenSize;
  double tileSize;
  List<Zombie> zombies;
  List<Survivor> survivors;
  Random rnd;

  DeadCityGame() {
    initialize();
  }

  void initialize() async {
    zombies = List<Zombie>();
    survivors = List<Survivor>();
    resize(await Flame.util.initialDimensions());
    rnd = Random();

    spawnZombie(100);
    spawnSurvivor(25);
  }

  void spawnZombie(int count) {
    for (int i = 1; i < count; i++) {
      double x = rnd.nextDouble() * (screenSize.width - tileSize);
      double y = rnd.nextDouble() * (screenSize.height - tileSize);
      zombies.add(Zombie(this, x, y));
    }
  }

  void spawnSurvivor(int count) {
    for (int i = 1; i < count; i++) {
      double x = rnd.nextDouble() * (screenSize.width - tileSize);
      double y = rnd.nextDouble() * (screenSize.height - tileSize);
      survivors.add(Survivor(this, x, y));
    }
  }

  void render(Canvas canvas) {
    createBackground(canvas);
    
    City city = City();
    city.createCity(canvas);

    zombies.forEach((Zombie z) => z.render(canvas));
    survivors.forEach((Survivor s) => s.render(canvas));
  }

  void createBackground(Canvas canvas) {
    Rect backgroundRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint();
    backgroundPaint.color = Color.fromRGBO(34, 139, 34, 75);
    canvas.drawRect(backgroundRect, backgroundPaint);
  }

  void update(double t) {
    zombies.forEach((Zombie z) => z.update(t));
    survivors.forEach((Survivor s) => s.update(t));
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }
}