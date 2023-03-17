import 'dart:ui';

import 'package:spritewidget/spritewidget.dart';
import 'package:test_game_2/celebrate_part.dart';

class CelebrateAnimationPart extends Node{
  final SpriteSheet sprites;
  final VoidCallback? onPerformedCelebrateAnimation;
  final String textureName;
  final double duration;
  final bool? isHorizontal;

  late CelebratePart part;

  CelebrateAnimationPart(this.sprites, this.onPerformedCelebrateAnimation, this.textureName, this.duration, [this.isHorizontal]){
    part = _createPart(textureName,  const Offset(500.0, 100.0));
    addChild(part);

    neutralPosition(false);
  }

  CelebratePart _createPart(String textureName, Offset pivotPosition){
    return CelebratePart(
      sprites[textureName]!,
      pivotPosition,
      name:textureName,
    );
  }

  void animate() {
    motions.stopAll();
    motions.run(
      MotionSequence(
        motions: [
          _createPoseAction(null, 0, duration),
          MotionCallFunction(callback: _animateLoop),
        ],
      ),
    );
  }

  void _animateLoop() {
    motions.run(
      MotionRepeatForever(
        motion: MotionSequence(
          motions: [
            _createPoseAction(0, 1, duration),
            _createPoseAction(1, 2, duration),
            _createPoseAction(2, 1, duration),
            _createPoseAction(1, 0, duration),
            MotionCallFunction(
              callback: () {
                if (onPerformedCelebrateAnimation != null) onPerformedCelebrateAnimation!();
              },
            ),
          ],
        ),
      ),
    );
  }

  void neutralPosition(bool animate) {
    motions.stopAll();
    if (animate) {
      motions.run(_createPoseAction(null, 1, duration));
    } else {
      List<double> d = _dataForPose(1);
      part.position = isHorizontal == true ? Offset(d[0], 0.0) : Offset(0.0, d[0]) ;
    }
  }

  MotionInterval _createPoseAction(
      int? startPose, int endPose, double duration) {
    List<double> d0 = _dataForPose(startPose);
    List<double> d1 = _dataForPose(endPose);

    List<MotionTween> tweens = <MotionTween>[
      MotionTween<Offset>(
        setter: (a) => part.position = a,
        start: isHorizontal == true ? Offset(d0[0], 0.0) : Offset(0.0 , d0[0]),
        end: isHorizontal == true ? Offset(d1[0], 0.0) : Offset(0.0, d1[0]),
        duration: duration,
      ),
    ];

    return MotionGroup(motions: tweens);
  }

  List<double> _dataForPose(int? pose) {
    if (pose == null) return _dataForCurrentPose();

    if (pose == 0) {
      return <double>[
        0.0
      ];
    } else if (pose == 1) {
      return <double>[-70.0];
    } else {
      return <double>[40.0];
    }
  }

  List<double> _dataForCurrentPose() {
    return <double>[
      isHorizontal == true ? part.position.dx : part.position.dy,
    ];
  }
}