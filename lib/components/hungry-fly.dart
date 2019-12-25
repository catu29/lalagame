import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:lalagame/components/fly.dart';
import 'package:lalagame/lalagame.dart';

class HungryFly extends Fly {
  double get speed => game.tileSize * 5;

  HungryFly(LalaGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.1, game.tileSize * 1.1);

    flyingSprite = List();
    flyingSprite.add(Sprite('flies/hungry-fly-1.png'));
    flyingSprite.add(Sprite('flies/hungry-fly-2.png'));
    deadSprite = Sprite('flies/hungry-fly-dead.png');
  }
}