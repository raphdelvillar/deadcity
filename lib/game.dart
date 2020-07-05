import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:deadcity/components/city.dart';
import 'package:deadcity/components/lot.dart';

import 'package:deadcity/components/zombie.dart';
import 'package:deadcity/components/survivor.dart';

class DeadCityGame extends Game {
  Size screenSize;
  double tileSize;
  List<Zombie> zombies;
  List<Survivor> survivors;
  Random rnd;
  City city;


  DeadCityGame() {
    initialize();
  }

  void initialize() async {
    zombies = List<Zombie>();
    survivors = List<Survivor>();
    city = City(this);
    resize(await Flame.util.initialDimensions());
    rnd = Random();

    spawnZombie(1);
    spawnSurvivor(100);
  }

  void spawnZombie(int count) {
    for (int i = 0; i < count; i++) {
      double x = rnd.nextDouble() * (screenSize.width - tileSize);
      double y = rnd.nextDouble() * (screenSize.height - tileSize);
      zombies.add(Zombie(this, this.survivors, this.zombies, x, y));
    }
  }

  void spawnSurvivor(int count) {
    for (int i = 0; i < count; i++) {
      double x = rnd.nextDouble() * (screenSize.width - tileSize);
      double y = rnd.nextDouble() * (screenSize.height - tileSize);
      survivors.add(Survivor(this, this.zombies, x, y, true));
    }
  }

  void render(Canvas canvas) {
    createBackground(canvas);
    
    city.spawnCity();
    city.lots.forEach((Lot l) {
      l.zombies = zombies;
      l.survivors = survivors;
      l.render(canvas);
    });
    zombies.forEach((Zombie z) => z.render(canvas));
    survivors.forEach((Survivor s) => s.render(canvas));
  }

  void createBackground(Canvas canvas) {
    Rect backgroundRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint();
    backgroundPaint.color = Color.fromRGBO(0, 0, 0, 100);
    canvas.drawRect(backgroundRect, backgroundPaint);
  }

  void update(double t) {
    zombies.forEach((Zombie z) => z.update(t));
    survivors.forEach((Survivor s) => s.update(t));
    city.lots.forEach((Lot l) => l.update(t));
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }
}