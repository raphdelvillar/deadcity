import 'dart:ui';
import 'package:deadcity/game.dart';
import 'package:deadcity/components/lot.dart';

class City {
  final DeadCityGame game;
  List<Lot> lots;

  City(this.game) {
    initialize();
  }

  void initialize() async {
    lots = List<Lot>();
    spawnCity();
  }

  void spawnCity() {
    double top = 155.0;
    for (int i = 0; i <= 7; i++) {
      spawnLotRow(top);
      top = (top + 70.0).toDouble();
    }
  }

  void spawnLotRow(double top) {
    double length = 14.0;
    for (int i = 1; i <= 6; i++) {
      lots.add(Lot(this.game, length, top));
      length = (length + 65.0).toDouble();
    }
  }
}