import 'dart:ui';

import 'package:spritewidget/spritewidget.dart';
import 'package:test_game_2/celebrate_part.dart';

class CelebrateAnimationSide extends Node{
  final SpriteSheet sprites;
  final VoidCallback? onPerformedCelebrateAnimation;

  late CelebratePart left;
  late CelebratePart right;
  late CelebratePart top;

  CelebrateAnimationSide(bool isRight, this.sprites, this.onPerformedCelebrateAnimation){
    top = _createPart('center.png',  const Offset(500.0, 50.0));
    addChild(top);

    if (isRight) {
      top.opacity = 0.0;
      top.scaleX = -1.0;
    }
    left = _createPart('left.png', const Offset(300.0, -650.0));
    top.addChild(left);
    top.setPivotAndPosition(Offset.zero);

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
          _createPoseAction(null, 0, 0.1),
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
            _createPoseAction(0, 1, 0.1),
            _createPoseAction(1, 2, 0.1),
            _createPoseAction(2, 1, 0.1),
            _createPoseAction(1, 0, 0.1),
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
      motions.run(_createPoseAction(null, 1, 0.1));
    } else {
      List<double> d = _dataForPose(1);
      left.position = Offset(0.0, d[0]);
      top.position = Offset(d[1], 0.0);
    }
  }

  MotionInterval _createPoseAction(
      int? startPose, int endPose, double duration) {
    List<double> d0 = _dataForPose(startPose);
    List<double> d1 = _dataForPose(endPose);

    List<MotionTween> tweens = <MotionTween>[
      MotionTween<Offset>(
        setter: (a) => left.position = a,
        start: Offset(0.0, d0[0]),
        end: Offset(0.0, d1[0]),
        duration: duration,
      ),
      MotionTween<Offset>(
        setter: (a) => top.position = a,
        start: Offset(d0[1], 0.0),
        end: Offset(d1[1], 0.0),
        duration: duration,
      )
    ];

    return MotionGroup(motions: tweens);
  }

  List<double> _dataForPose(int? pose) {
    if (pose == null) return _dataForCurrentPose();

    if (pose == 0) {
      return <double>[
        10.0, // Upper arm rotation
        0.0 // Torso y offset
      ];
    } else if (pose == 1) {
      return <double>[-70.0, 40.0];
    } else {
      return <double>[40.0, -70.0];
    }
  }

  List<double> _dataForCurrentPose() {
    return <double>[
      left.position.dy,
      top.position.dx
    ];
  }
}