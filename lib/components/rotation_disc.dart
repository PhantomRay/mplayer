import 'package:flutter/material.dart';

class RotationDisc extends StatefulWidget {
  final Widget child;
  final bool play;

  RotationDisc({Key key, this.child, this.play = true}) : super(key: key);

  @override
  _RotationDiscState createState() => _RotationDiscState();
}

class _RotationDiscState extends State<RotationDisc> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  CurvedAnimation animation;

  @override
  void initState() {
    animationController = new AnimationController(duration: const Duration(milliseconds: 5000), vsync: this);
    animation = new CurvedAnimation(parent: animationController, curve: Curves.linear);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.repeat();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.play ? animationController.forward() : animationController.stop();
    return RotationTransition(
      turns: animation,
      child: widget.child,
    );
  }
}
