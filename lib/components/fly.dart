import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:lalagame/lalagame.dart';
import 'package:lalagame/view.dart';
import 'package:lalagame/components/callout.dart';

class Fly {
  final LalaGame game;
  Rect flyRect;
  
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;

  bool isDead = false;
  bool isOffScreen = false;

  Callout callout;

  double get speed => game.tileSize * 4;
  Offset targetLocation;

  Fly(this.game) {
    setTargetLocation();
    callout = Callout(this, this.game.calloutValue);
  }

  void render(Canvas canvas) {
    if (isDead) {
      deadSprite.renderRect(canvas, flyRect.inflate(flyRect.width / 2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(canvas, flyRect.inflate(flyRect.width / 2));
      
      if (game.activeView == View.play) {
        callout.render(canvas);
      }
    }
  }

  void update(double dt) {
    if (isDead) {
      flyRect = flyRect.translate(0, game.tileSize * 12 * dt);

      if (flyRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    } else {
      callout.update(dt);

      flyingSpriteIndex += 30 * dt;
      
      while (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }

      double stepDistance = speed * dt;
      Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
      
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
        flyRect = flyRect.shift(stepToTarget);
      } else {
        flyRect = flyRect.shift(toTarget);
        setTargetLocation();
      }
    }
  }

  void onTapDown() {
    isDead = true;

    if (game.activeView == View.play) {
      game.score++;

      if (game.score > (game.storage.getInt('highscore') ?? 0)) {
        game.storage.setInt('highscore', game.score);
        game.highscoreDisplay.updateHighscore();
      }
    }

    if (game.soundButton.isEnabled) {
      Flame.audio.play('sfx/ouch' + (game.random.nextInt(11) + 1).toString() + '.mp3');
    }
  }

  void setTargetLocation() {
    double x = game.random.nextDouble() * (game.screenSize.width - (game.tileSize * 1.25));
    double y = (game.random.nextDouble() * (game.screenSize.height - (game.tileSize * 1.75))) + game.tileSize * 1.5;
    targetLocation = Offset(x, y);
  }
}