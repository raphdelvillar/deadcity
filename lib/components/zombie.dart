import 'dart:ui';
import 'package:deadcity/game.dart';

class Zombie {
  final DeadCityGame game;
  Rect zRect;
  double zSize;
  Paint paint = Paint();

  double get speed => game.tileSize * 0.25;
  Offset targetLocation;

  Zombie(this.game, double x, double y) {
    zRect = Rect.fromLTWH(x, y, 10, 10);
    paint.color = Color.fromRGBO(220, 20, 60, 75);
    setTargetLocation();
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() * (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rnd.nextDouble() * (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }

  void render(Canvas c) {
    c.drawRect(zRect, paint);
  }

  void update(double t) {
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