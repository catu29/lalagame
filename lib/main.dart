import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flame/flame.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lalagame/lalagame.dart';
import 'package:lalagame/bgm.dart';

void main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  Flame.images.loadAll(<String>[
    'bg/backyard.png',
    'flies/agile-fly-1.png',
    'flies/agile-fly-2.png',
    'flies/agile-fly-dead.png',
    'flies/drooler-fly-1.png',
    'flies/drooler-fly-2.png',
    'flies/drooler-fly-dead.png',
    'flies/house-fly-1.png',
    'flies/house-fly-2.png',
    'flies/house-fly-dead.png',
    'flies/hungry-fly-1.png',
    'flies/hungry-fly-2.png',
    'flies/hungry-fly-dead.png',
    'flies/macho-fly-1.png',
    'flies/macho-fly-2.png',
    'flies/macho-fly-dead.png',
    'bg/lose-splash.png',
    'branding/title.png',
    'ui/dialog-help.png',
    'ui/icon-help.png',
    'ui/icon-music-disabled.png',
    'ui/icon-music-enabled.png',
    'ui/icon-sound-disabled.png',
    'ui/icon-sound-enabled.png',
    'ui/start-button.png',
    'ui/callout.png',
  ]);

  Flame.audio.disableLog();
  Flame.audio.loadAll(<String>[
    'bgm/home.mp3',
    'bgm/playing.mp3',
    'sfx/haha1.mp3',
    'sfx/haha2.mp3',
    'sfx/haha3.mp3',
    'sfx/haha4.mp3',
    'sfx/haha5.mp3',
    'sfx/ouch1.mp3',
    'sfx/ouch2.mp3',
    'sfx/ouch3.mp3',
    'sfx/ouch4.mp3',
    'sfx/ouch5.mp3',
    'sfx/ouch6.mp3',
    'sfx/ouch7.mp3',
    'sfx/ouch8.mp3',
    'sfx/ouch9.mp3',
    'sfx/ouch10.mp3',
    'sfx/ouch11.mp3',
  ]);

  SharedPreferences storage = await SharedPreferences.getInstance();

  LalaGame game = new LalaGame(storage);
  TapGestureRecognizer  tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  runApp(game.widget);
  BGM.attachWidgetBindingListener();
  flameUtil.addGestureRecognizer(tapper);
}
