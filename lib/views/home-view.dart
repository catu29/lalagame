import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:lalagame/lalagame.dart';

class HomeView {
  final LalaGame game;
  Rect titleRect;
  Sprite titleSprite;

  HomeView(this.game) {
    titleRect = Rect.fromLTWH(
      game.tileSize / 2,
      (game.screenSize.height / 2) - (game.tileSize * 4),
      game.tileSize * 8,
      game.tileSize * 4,
    );

    titleSprite = Sprite('branding/title.png');
  }

  void render(Canvas canvas) {
    titleSprite.renderRect(canvas, titleRect);
  }

  void update(double t) {}
}