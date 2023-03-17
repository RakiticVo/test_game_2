import 'dart:ui';

import 'package:spritewidget/spritewidget.dart';

class CelebratePart extends Sprite{
  String name;
  final Offset pivotPosition;

  CelebratePart(SpriteTexture texture, this.pivotPosition, {this.name = ''}) : super(texture: texture);

  void setPivotAndPosition(Offset newPosition) {
    pivot = Offset(pivotPosition.dx / 1024.0, pivotPosition.dy / 1024.0);
    position = newPosition;

    for (Node child in children) {
      CelebratePart subPart = child as CelebratePart;
      subPart.setPivotAndPosition(Offset(subPart.pivotPosition.dx - pivot.dx,
          subPart.pivotPosition.dy - pivot.dy));
      /*subPart.setPivotAndPosition(
          new Offset(subPart.pivotPosition.dx, subPart.pivotPosition.dy));*/
    }
  }
}