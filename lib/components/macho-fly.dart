import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:lalagame/components/fly.dart';
import 'package:lalagame/lalagame.dart';

class MachoFly extends Fly {
  double get speed => game.tileSize * 5;

  MachoFly(LalaGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.25, game.tileSize * 1.25);

    flyingSprite = List();
    flyingSprite.add(Sprite('flies/macho-fly-1.png'));
    flyingSprite.add(Sprite('flies/macho-fly-2.png'));
    deadSprite = Sprite('flies/macho-fly-dead.png');
  }
}