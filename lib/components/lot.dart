import 'dart:math';
import 'dart:ui';
import 'package:deadcity/game.dart';
import 'package:deadcity/components/building.dart';
import 'package:deadcity/components/zombie.dart';
import 'package:deadcity/components/survivor.dart';
import 'package:flame/flame.dart';

class Lot {
  final DeadCityGame game;
  Rect lRect;
  Paint paint = Paint();

  Offset targetLocation;

  Building building;

  List<Zombie> zombies = <Zombie>[];
  List<Survivor> survivors = <Survivor>[];

  bool isOwned = false;

  Lot(this.game, double x, double y) {
    lRect = Rect.fromLTWH(x, y, 65, 70);
    paint.color = Color.fromRGBO(0, 0, 0, 100);

    building = Building(this.game, x+8, y+10);

    setTargetLocation();
  }

  void render(Canvas c) {
    building.render(c);
    c.drawRect(lRect, paint);
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() * (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rnd.nextDouble() * (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }

  void update(double t) {
    infected(t);
    owned(t);
  }

  void infected(double t) {
    if (zombies.isNotEmpty) {
      zombies.forEach((zombie) {
        if (lRect.contains(zombie.zRect.center)) {
          if (isOwned) {
            Random rnd = new Random();
            Flame.audio.play('sfx/fire' + (rnd.nextInt(3) + 1).toString() + '.mp3');
            zombie.health -=50;
            if (zombie.health < 0) {
              zombies.remove(zombie);
            }
          }
        }

        if (!isOwned) {
          if (building.bRect.contains(zombie.zRect.center)) {
            building.paint.color = Color.fromRGBO(139, 0, 0, 25);
          }
        }
      });
    }
  }

  void owned(double t) {
    if (survivors.isNotEmpty) {
      survivors.forEach((survivor) {
        if (building.bRect.contains(survivor.sRect.center)) {
          isOwned = true;
          paint.color = Color.fromRGBO(255, 255, 244, 100);
          building.paint.color = Color.fromRGBO(135, 206, 250, 100);
        } else {
          isOwned = false;
        }
      });
    }
  }
}