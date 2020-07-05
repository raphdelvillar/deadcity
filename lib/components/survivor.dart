import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:deadcity/game.dart';
import 'package:deadcity/components/zombie.dart';

class Survivor {
  final DeadCityGame game;
  Rect sRect;
  double sSize;
  Paint paint = Paint();

  double speed;
  Offset targetLocation;

  bool mobile;

  List<Zombie> zombies = <Zombie>[];

  Survivor(this.game, this.zombies, double x, double y, this.mobile) {
    speed = this.game.tileSize * 0.25;
    sRect = Rect.fromLTWH(x, y, 10, 10);
    paint.color = Color.fromRGBO(135, 206, 250, 100);
    setTargetLocation();
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() * (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rnd.nextDouble() * (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }

  void render(Canvas c) {
    c.drawRect(sRect, paint);
  }

  void update(double t) {
    if (mobile) {
      wander(t);
    }
  }

  void wander(double t) {
    double stepDistance = speed * t;
    Offset toTarget = targetLocation - Offset(sRect.left, sRect.top); 
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
      sRect = sRect.shift(stepToTarget);
    } else {
      sRect = sRect.shift(toTarget);
      setTargetLocation();
    }
  }

  void playDeathAudio() {
    Random rnd = new Random();
    Flame.audio.play('sfx/survivor_death' + (rnd.nextInt(2) + 1).toString() + '.mp3');
  }
}