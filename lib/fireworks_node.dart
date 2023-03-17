import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

class FireworksNode extends NodeWithSize {
  final SpriteSheet _sprites;
  FireworksNode(this._sprites) : super(const Size(1024.0, 1024.0));
  double _countDown = 0.0;

  @override
  void update(double dt) {
    if (_countDown <= 0.0) {
      _addExplosion();
      _countDown = randomDouble();
    }

    _countDown -= dt;
  }

  Color _randomExplosionColor() {
    double rand = randomDouble();
    if (rand < 0.25) {
      return Colors.deepOrange;
    } else if (rand < 0.5) {
      return Colors.purple;
    } else if (rand < 0.75) {
      return Colors.indigo;
    } else {
      return Colors.red;
    }
  }

  void _addExplosion() {
    Color startColor = _randomExplosionColor();
    Color endColor = startColor.withAlpha(100);

    ParticleSystem system = ParticleSystem(
      texture: _sprites["left.png"]!,
      numParticlesToEmit: 100,
      emissionRate: 1000.0,
      rotateToMovement: true,
      startRotation: 90.0,
      endRotation: 90.0,
      speed: 100.0,
      speedVar: 50.0,
      startSize: 1.0,
      startSizeVar: 0.5,
      gravity: const Offset(0.0, 30.0),
      colorSequence: ColorSequence.fromStartAndEndColor(
        start: startColor,
        end: endColor,
      ),
    );
    system.position = Offset(randomDouble() * 1024.0, randomDouble() * 1024.0);
    addChild(system);
  }

  void _addAnimation(){

  }
}