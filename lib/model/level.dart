import 'package:flutter/cupertino.dart';

class Level {
  String image;
  IconData icon;
  String levelNumber;
  String levelName;
  List<Color> Colors;
  Widget screen ;

  Level(this.image, this.icon, this.levelNumber, this.levelName, this.Colors , this.screen);
}
