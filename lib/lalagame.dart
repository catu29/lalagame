import 'dart:ui';
import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lalagame/view.dart';
import 'package:lalagame/bgm.dart';
import 'package:lalagame/components/fly.dart';
import 'package:lalagame/components/agile-fly.dart';
import 'package:lalagame/components/drooler-fly.dart';
import 'package:lalagame/components/house-fly.dart';
import 'package:lalagame/components/hungry-fly.dart';
import 'package:lalagame/components/macho-fly.dart';
import 'package:lalagame/components/backyard.dart';
import 'package:lalagame/components/start-button.dart';
import 'package:lalagame/components/help-button.dart';
import 'package:lalagame/components/music-button.dart';
import 'package:lalagame/components/sound-button.dart';
import 'package:lalagame/components/score-display.dart';
import 'package:lalagame/components/high-score-display.dart';
import 'package:lalagame/views/help-view.dart';
import 'package:lalagame/views/home-view.dart';
import 'package:lalagame/views/lose-view.dart';
import 'package:lalagame/controllers/spawn-controller.dart';


class LalaGame extends Game {
  Size screenSize;
  double tileSize;
  bool isWon = false;
  Random random;
  int score = 0;
  double calloutValue = 3;

  final SharedPreferences storage;

  Backyard backyard;
  List<Fly> flies;

  View activeView = View.home;
  HomeView homeView;
  LoseView loseView;
  HelpView helpView;

  StartButton startButton;
  HelpButton helpButton;
  MusicButton musicButton;
  SoundButton soundButton;

  ScoreDisplay scoreDisplay;
  HighscoreDisplay highscoreDisplay;

  FlySpawner flySpawner;

  LalaGame(this.storage) {
    initialize();
  }

  void initialize() async {
    flies = List<Fly>();
    random = Random();

    resize(await Flame.util.initialDimensions());

    await BGM.add('bgm/home.mp3');
    await BGM.add('bgm/playing.mp3');

    homeView = HomeView(this);
    loseView = LoseView(this);
    helpView = HelpView(this);

    startButton = StartButton(this);
    helpButton = HelpButton(this);
    musicButton = MusicButton(this);
    soundButton = SoundButton(this);

    scoreDisplay = ScoreDisplay(this);
    highscoreDisplay = HighscoreDisplay(this);
    
    backyard = Backyard(this);

    flySpawner = FlySpawner(this);

    if (musicButton.isEnabled) {
      await BGM.play(0);
    }
  }

  @override
  void render(Canvas canvas) {
    backyard.render(canvas);
    highscoreDisplay.render(canvas);
    musicButton.render(canvas);
    soundButton.render(canvas);

    if (activeView == View.play) {
      scoreDisplay.render(canvas);
    }

    flies.forEach((Fly fly) => fly.render(canvas));

    if (activeView == View.home) {
      homeView.render(canvas);

      startButton.render(canvas);
      helpButton.render(canvas);
    }
    
    if (activeView == View.lose) {
      loseView.render(canvas);

      startButton.render(canvas);
      helpButton.render(canvas);
    }
    
    if (activeView == View.help) {
      helpView.render(canvas);
    }
  }

  @override
  void update(double dt) {
    if (calloutValue > 1) {
      calloutValue -= .0025 * dt;
    } 

    flySpawner.update(dt);

    flies.forEach((Fly fly) => fly.update(dt));
    flies.removeWhere((Fly fly) => fly.isOffScreen);

    if (activeView == View.play) scoreDisplay.update(dt);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    super.resize(size);
  }

  void spawnFly() {
    double x = random.nextDouble() * (screenSize.width - tileSize * 1.25);
    double y = (random.nextDouble() * (screenSize.height - tileSize * 2.75)) + tileSize * 1.5;

    switch (random.nextInt(5)) {
      case 0:
        flies.add(HouseFly(this, x, y));
        break;
      case 1:
        flies.add(DroolerFly(this, x, y));
        break;
      case 2:
        flies.add(AgileFly(this, x, y));
        break;
      case 3:
        flies.add(MachoFly(this, x, y));
        break;
      case 4:
        flies.add(HungryFly(this, x, y));
        break;
    }
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    if (!isHandled && musicButton.rect.contains(d.globalPosition)) {
      musicButton.onTapDown();
      isHandled = true;
    }

    if (!isHandled && soundButton.rect.contains(d.globalPosition)) {
      soundButton.onTapDown();
      isHandled = true;
    }

    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lose) {
        startButton.onTapDown();

        if (musicButton.isEnabled) {
           BGM.play(1);
        }

        isHandled = true;
        score = 0;
      }
    }

    if (!isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lose) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }

    if (!isHandled && activeView == View.help) {
      activeView = View.home;
      isHandled = true;
    }

    if (!isHandled) {
      bool hitFly = false;

      flies.forEach((Fly fly) {
        if (fly.flyRect.contains(d.globalPosition)) {
          fly.onTapDown();
          hitFly = true;
          isHandled = true;
        }
      });

      if (!hitFly && activeView == View.play) {
        if (soundButton.isEnabled) {
          Flame.audio.play('sfx/haha' + (random.nextInt(5) + 1).toString() + '.mp3');
        }

        if (musicButton.isEnabled) {
          BGM.play(0);
        }

        activeView = View.lose;
      }
    }
  }
}