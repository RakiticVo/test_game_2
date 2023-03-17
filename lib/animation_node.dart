import 'dart:ui';

import 'package:spritewidget/spritewidget.dart';
import 'package:test_game_2/celebrate_animation.dart';

class AnimationNode extends NodeWithSize{
  final SpriteSheet sprites;
  final VoidCallback onPerformedAnimation;
  final String textureName;
  final Offset position;
  final double duration;
  final bool? isHorizontal;

  late bool animationOut;
  late CelebrateAnimation celebrateAnimation;

  AnimationNode({
    required this.sprites,
    required this.onPerformedAnimation,
    required this.textureName,
    required this.position,
    required this.duration,
    this.isHorizontal
  }) : super(const Size(1024.0, 1024.0)){
    reset();

    celebrateAnimation = CelebrateAnimation(
      () {
        onPerformedAnimation();
      },
      sprites,
      textureName,
      duration,
      isHorizontal
    )
    ..scale = 0.5
    ..position = position;
    addChild(celebrateAnimation);
  }

  void reset() {
    animationOut = false;
  }

  void start() {
    reset();
    animationOut = true;
    celebrateAnimation.animate();
  }

  void stop() {
    animationOut = false;
    celebrateAnimation.neutralPose();
  }
}
