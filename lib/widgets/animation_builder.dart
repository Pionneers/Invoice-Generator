import 'package:flutter/material.dart';

class AnimationBuilderWidget extends StatelessWidget {
  final Animation<double> animation;
  final Widget widget;
  const AnimationBuilderWidget({Key? key, required this.animation, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation, 
      child: widget,
      builder: (context, child){
        return FadeTransition(
          opacity: animation, 
          child: Transform(
            transform: Matrix4.translationValues(0.0, 50 * (1.0 - animation.value), 0.0),
            child: child,
          ),
        );
      }
    );
  }
}