import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:lalagame/lalagame.dart';
import 'package:lalagame/bgm.dart';
import 'package:lalagame/view.dart';

class MusicButton {
  final LalaGame game;
  Rect rect;
  Sprite enabledSprite;
  Sprite disabledSprite;
  bool isEnabled;

  MusicButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * .25,
      game.tileSize * .25,
      game.tileSize,
      game.tileSize,
    );
    enabledSprite = Sprite('ui/icon-music-enabled.png');
    disabledSprite = Sprite('ui/icon-music-disabled.png');

    isEnabled = game.storage.getBool('music') ?? true;
  }

  void render(Canvas c) {
    if (isEnabled) {
      enabledSprite.renderRect(c, rect);
    } else {
      disabledSprite.renderRect(c, rect);
    }
  }

  void onTapDown() {
    if (isEnabled) {
      isEnabled = false;
      game.storage.setBool('music', false);
      BGM.stop();
    } else {
      isEnabled = true;
      game.storage.setBool('music', true);
      
      if (game.activeView == View.play) {
        BGM.play(1);
      } else {
        BGM.play(0);
      }
    }
  }
}