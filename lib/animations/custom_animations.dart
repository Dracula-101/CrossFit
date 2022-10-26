import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

const int delay = 500;
const int duration = 500;

Widget verticalAnimation(
    {required Widget child,
    required int position,
    int delay = delay,
    int duration = duration}) {
  return AnimationConfiguration.staggeredList(
    position: position,
    delay: Duration(milliseconds: delay),
    duration: Duration(milliseconds: duration),
    child: SlideAnimation(
        verticalOffset: 30.0, child: FadeInAnimation(child: child)),
  );
}

Widget slideAnimation(
    {required Widget child,
    required int position,
    int delay = delay,
    int duration = duration}) {
  return AnimationConfiguration.staggeredList(
    position: position,
    delay: Duration(milliseconds: delay),
    duration: Duration(milliseconds: duration),
    child: SlideAnimation(
        horizontalOffset: 30.0, child: FadeInAnimation(child: child)),
  );
}

Widget leftSlideAnimation(
    {required Widget child,
    required int position,
    int delay = delay,
    int duration = duration}) {
  return AnimationConfiguration.staggeredList(
    position: position,
    delay: Duration(milliseconds: delay),
    duration: Duration(milliseconds: duration),
    child: SlideAnimation(
        horizontalOffset: -30.0, child: FadeInAnimation(child: child)),
  );
}

Widget rightSlideAnimation(
    {required Widget child,
    required int position,
    int delay = delay,
    int duration = duration}) {
  return AnimationConfiguration.staggeredList(
    position: position,
    delay: Duration(milliseconds: delay),
    duration: Duration(milliseconds: duration),
    child: SlideAnimation(
        horizontalOffset: 30.0, child: FadeInAnimation(child: child)),
  );
}

Widget scaleAnimation(
    {required Widget child,
    required int position,
    int delay = delay,
    int duration = duration}) {
  return AnimationConfiguration.staggeredList(
    position: position,
    delay: Duration(milliseconds: delay),
    duration: Duration(milliseconds: duration),
    child: ScaleAnimation(child: FadeInAnimation(child: child)),
  );
}

Widget scaleAnimationWithDelay(
    {required Widget child,
    required int position,
    int delay = delay,
    int duration = duration}) {
  return AnimationConfiguration.staggeredList(
    position: position,
    delay: Duration(milliseconds: delay),
    duration: Duration(milliseconds: duration),
    child: ScaleAnimation(
      child: FadeInAnimation(
        child: child,
      ),
    ),
  );
}

Widget scaleAnimationWithDelayAndDuration(Widget child, int position,
    {int delay = delay, int duration = duration}) {
  return AnimationConfiguration.staggeredList(
    position: position,
    delay: Duration(milliseconds: delay),
    duration: Duration(milliseconds: duration),
    child: ScaleAnimation(
      child: FadeInAnimation(
        child: child,
      ),
    ),
  );
}

Widget scaleAnimationWithDelayAndDurationAndOffset(Widget child, int position,
    {int delay = 500, int duration = 500, double offset = 30.0}) {
  return AnimationConfiguration.staggeredList(
    position: position,
    delay: Duration(milliseconds: delay),
    duration: Duration(milliseconds: duration),
    child: ScaleAnimation(
      child: FadeInAnimation(
        child: SlideAnimation(
          verticalOffset: offset,
          child: child,
        ),
      ),
    ),
  );
}






