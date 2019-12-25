import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:lalagame/components/fly.dart';
import 'package:lalagame/lalagame.dart';

class AgileFly extends Fly {
  double get speed => game.tileSize * 6;

  AgileFly(LalaGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);

    flyingSprite = List();
    flyingSprite.add(Sprite('flies/agile-fly-1.png'));
    flyingSprite.add(Sprite('flies/agile-fly-2.png'));
    deadSprite = Sprite('flies/agile-fly-dead.png');
  }
}