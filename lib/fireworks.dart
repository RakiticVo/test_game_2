import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'fireworks_node.dart';

class Fireworks extends StatefulWidget {
  final SpriteSheet sprites;
  const Fireworks({Key? key, required this.sprites}) : super(key: key);

  @override
  FireworksState createState() => FireworksState();
}

class FireworksState extends State<Fireworks> {
  @override
  void initState() {
    super.initState();
    fireworks = FireworksNode(widget.sprites);
  }

  late FireworksNode fireworks;

  @override
  Widget build(BuildContext context) {
    return SpriteWidget(fireworks);
  }
}