import 'dart:ui';
import 'package:deadcity/game.dart';

class Survivor {
  final DeadCityGame game;
  Rect sRect;
  double sSize;
  Paint paint = Paint();

  double get speed => game.tileSize * 1;
  Offset targetLocation;

  Survivor(this.game, double x, double y) {
    sRect = Rect.fromLTWH(x, y, 10, 10);
    paint.color = Color.fromRGBO(135, 206, 250, 75);
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
}