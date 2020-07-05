import 'dart:math';
import 'dart:ui';
import 'package:deadcity/game.dart';
import 'package:deadcity/components/survivor.dart';

class Zombie {
  final DeadCityGame game;
  Rect zRect;
  double zSize;
  Paint paint = Paint();
  Offset targetLocation;

  List<Survivor> survivors = <Survivor>[];
  List<Zombie> zombies = <Zombie>[];

  double health = 0;
  double speed = 0;

  Zombie(this.game, this.survivors, this.zombies, double x, double y) {
    zRect = Rect.fromLTWH(x, y, 10, 10);
    paint.color = Color.fromRGBO(220, 20, 60, 100);
    initStat();
    setTargetLocation();
  }

  void initStat() {
    Random rnd = new Random();
    double rh = 1.00 + rnd.nextInt(100);
    health = rh;

    setOpacity(rh);

    double rs = 0.25 + rnd.nextInt(1);
    speed = game.tileSize * rs;
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() * (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rnd.nextDouble() * (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }

  void render(Canvas c) {
    c.drawRect(zRect, paint);
  }

  void setOpacity(double op) {
    paint.color = Color.fromRGBO(220, 20, 60, op);
  }

  void update(double t) {
    infect(t);
    wander(t);
  }

  void infect(double t) {
    if (survivors.isNotEmpty) {
      survivors.forEach((survivor) {
        bool remove = this.zRect.contains(survivor.sRect.center);
        if (remove) {
          double x = survivor.targetLocation.dx;
          double y = survivor.targetLocation.dy;
          survivor.playDeathAudio();
          survivors.remove(survivor);
          zombies.add(Zombie(this.game, this.survivors, this.zombies, x, y));
        }
      });
    }
  }

  void wander(double t) {
    double stepDistance = speed * t;

    Offset toTarget = targetLocation - Offset(zRect.left, zRect.top); 
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
      zRect = zRect.shift(stepToTarget);
    } else {
      zRect = zRect.shift(toTarget);
      setTargetLocation();
    }
  }
}