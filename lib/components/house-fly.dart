import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:lalagame/components/fly.dart';
import 'package:lalagame/lalagame.dart';

class HouseFly extends Fly {
  HouseFly(LalaGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);

    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('flies/house-fly-1.png'));
    flyingSprite.add(Sprite('flies/house-fly-2.png'));
    deadSprite = Sprite('flies/house-fly-dead.png');
  }
}