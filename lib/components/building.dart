import 'dart:ui';
import 'package:deadcity/game.dart';

class Building {
  final DeadCityGame game;
  Rect bRect;
  Paint paint = Paint();

  Offset targetLocation;

  Building(this.game, double x, double y) {
    bRect = Rect.fromLTWH(x, y, 50, 50);
    paint.color = Color.fromRGBO(192, 192, 192, 100);
    setTargetLocation();
  }

  void render(Canvas c) {
    c.drawRect(bRect, paint);
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() * (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rnd.nextDouble() * (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }

  void update(double t) {
  }

}