import 'dart:ui';

import 'package:spritewidget/spritewidget.dart';

import 'celebrate_animation_part.dart';

class CelebrateAnimation extends Node {
 final SpriteSheet sprites;
 final String textureName;
 final double duration;
 final bool? isHorizontal;
 late CelebrateAnimationPart part;

 CelebrateAnimation(VoidCallback onPerformedCelebrateAnimation, this.sprites, this.textureName, this.duration, [this.isHorizontal]){
   part = CelebrateAnimationPart(sprites, onPerformedCelebrateAnimation, textureName, duration, isHorizontal);
   addChild(part);
 }


 void animate() {
   part.animate();
 }

 void neutralPose() {
   part.neutralPosition(true);
 }
}