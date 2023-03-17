import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:test_game_2/animation_node.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late ImageMap _images;
  late SpriteSheet sprites;
  bool isFireworkShow = false;
  late AnimationNode animationNode1;
  late AnimationNode animationNode2;
  late AnimationNode animationNode3;

  Future<void> _loadAssets(AssetBundle bundle) async {
    _images = ImageMap();
    await _images.load([
      'assets/spritesheet.png',
    ]);

    String json = await DefaultAssetBundle.of(context)
        .loadString('assets/spritesheet.json');

    sprites = SpriteSheet(
      image: _images.getImage('assets/spritesheet.png')!,
      jsonDefinition: json,
    );
  }

  @override
  void initState() {
    super.initState();
    _loadAssets(rootBundle).then((_) {
      setState(() {
        _assetsLoaded = true;
        animationNode1 = AnimationNode(
          sprites: sprites,
          onPerformedAnimation: (){

          },
          textureName: 'center.png',
          position: const Offset(560.0, 260.0),
          duration: 0.25,
          isHorizontal: true
        );
        animationNode2 = AnimationNode(
          sprites: sprites,
          onPerformedAnimation: (){

          },
          textureName: 'left.png',
          position: const Offset(800.0, 700.0),
          duration: 0.4
        );
        animationNode3 = AnimationNode(
          sprites: sprites,
          onPerformedAnimation: (){

          },
          textureName: 'right.png',
          position: const Offset(250.0, 700.0),
          duration: 0.4
        );
      });
    });
  }

  bool _assetsLoaded = false;
  bool _isDelay = true;
  bool isPressAll = false;
  bool isPressBtnCenter = false;
  bool isPressBtnRight = false;
  bool isPressBtnLeft = false;

  @override
  Widget build(BuildContext context) {
    if (!_assetsLoaded) return Container();

    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, top: 50.0),
                    child: Transform.scale(
                        scale: 0.9,
                        child: Image.asset('assets/img.png')
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: SpriteWidget(
                      animationNode1,
                      transformMode: SpriteBoxTransformMode.letterbox,
                    ),
                  ),
                  Visibility(
                    visible: _isDelay,
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.transparent),
                      child: SpriteWidget(
                        animationNode2,
                        transformMode: SpriteBoxTransformMode.letterbox,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isDelay,
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.transparent),
                      child: SpriteWidget(
                        animationNode3,
                        transformMode: SpriteBoxTransformMode.letterbox,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SizedBox(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    isPressAll = !isPressAll;
                  });
                  if(isPressAll){
                    animationNode1.start();
                    animationNode2.start();
                    setState(() {
                      _isDelay = !_isDelay;
                    });
                    Future.delayed(const Duration(seconds: 1), () {
                      setState(() {
                        _isDelay = !_isDelay;
                      });
                      animationNode3.start();
                    });
                  }else{
                    animationNode1.stop();
                    animationNode2.stop();
                    animationNode3.stop();
                  }
                },
                // color: buttonColor,
                style: ElevatedButton.styleFrom(
                    backgroundColor: isPressAll ? Colors.red : Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    )
                ),
                child: Text(
                  isPressAll ? 'Stop Animate All' : 'Start Animate All',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SizedBox(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    isPressBtnCenter = !isPressBtnCenter;
                  });
                  isPressBtnCenter ? animationNode1.start() : animationNode1.stop();
                },
                // color: buttonColor,
                style: ElevatedButton.styleFrom(
                    backgroundColor: isPressBtnCenter ? Colors.red : Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    )
                ),
                child: Text(
                  isPressBtnCenter ? 'Stop Animate Center' : 'Start Animate Center',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SizedBox(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    isPressBtnRight = !isPressBtnRight;
                  });
                  isPressBtnRight ? animationNode2.start() : animationNode2.stop();
                },
                // color: buttonColor,
                style: ElevatedButton.styleFrom(
                    backgroundColor: isPressBtnRight ? Colors.red : Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    )
                ),
                child: Text(
                  isPressBtnRight ? 'Stop Animate Right' : 'Start Animate Right',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SizedBox(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    isPressBtnLeft = !isPressBtnLeft;
                  });
                  isPressBtnLeft ? animationNode3.start() : animationNode3.stop();
                },
                // color: buttonColor,
                style: ElevatedButton.styleFrom(
                    backgroundColor: isPressBtnLeft ? Colors.red : Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    )
                ),
                child: Text(
                  isPressBtnLeft ? 'Stop Animate Left' : 'Start Animate Left',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}