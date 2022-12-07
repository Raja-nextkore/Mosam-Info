import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps { opacity, translateX }

class FadeIn extends StatelessWidget {
  final Widget child;
  final double delay;

  const FadeIn({Key key, this.child, this.delay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, 0.0.tweenTo(1.0), 500.milliseconds)
      ..add(
          AniProps.translateX, Tween(begin: 130.0, end: 0.0), 500.milliseconds);
    return PlayAnimation(
      delay: Duration(milliseconds: (300 * delay).round()),
      tween: _tween,
      duration: _tween.duration,
      child: child,
      builder: (context, child, MultiTweenValues value) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: Transform.translate(
          offset: Offset(value.get(AniProps.translateX), 0),
          child: child,
        ),
      ),
    );
  }
}
