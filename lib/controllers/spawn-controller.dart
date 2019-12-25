import 'package:lalagame/lalagame.dart';
import 'package:lalagame/components/fly.dart';

class FlySpawner {
  final LalaGame game;
  
  final int maxInterval = 2000;
  final int minInterval = 250;
  final int reduceInterval = 50;
  final int maxFlies = 7;

  int currentInterval;
  int nextSpawn;

  FlySpawner(this.game) {
    start();
    game.spawnFly();
  }

  void start() {
    killAll();

    currentInterval = maxInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAll() {
    game.flies.forEach((Fly fly) => fly.isDead = true);
  }

  void update(double dt) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;
    int count = 0;

    game.flies.forEach((Fly fly) {
      if (!fly.isDead) {
        count++;
      }
    });

    if (nowTimestamp >= nextSpawn && count < maxFlies) {
      game.spawnFly();

      if (currentInterval > minInterval) {
        currentInterval -= reduceInterval;
        currentInterval -= (currentInterval * .02).toInt();
      }
      
      nextSpawn = nowTimestamp + currentInterval;
    }
  }
}