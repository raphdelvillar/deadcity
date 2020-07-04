import 'dart:ui';

class City {
  List<String> listOfBuildingType = ["small", "medium", "large"];

  void createCity(Canvas canvas) {
    double top = 155.0;
    for (int i = 1; i <= 8; i++) {
      createBuildingRow(canvas, top);
      top = (top + 70.0).toDouble();
    }
  }

  void createBuildingRow(Canvas canvas, double top) {
    double length = 15.0;
    for (int i = 1; i <= 6; i++) { 
      String buildingType = (listOfBuildingType..shuffle()).first;
      createBuilding(canvas, length, top, buildingType);
      length = (length + 65.0).toDouble();
    }
  }

  void createBuilding(Canvas canvas, double left, double top, String buildingType) {
    double width, height;

    switch(buildingType) {
      // case "large":
      //   width = 60.0;
      //   height = 60.0;
      //   break;
      // case "medium":
      //   width = 55.0;
      //   height = 55.0;
      //   break;
      default:
        width = 50.0;
        height = 50.0;
    }

    Rect buildingRect = Rect.fromLTWH(left, top, width, height);

    Paint buildingPaint = Paint();
    buildingPaint.color = Color.fromRGBO(192, 192, 192, 100);

    canvas.drawRect(buildingRect, buildingPaint);
  }

}