import 'dart:math';

import 'package:flutter/material.dart';

abstract class Loader extends StatefulWidget {
  @override
  // ignore: no_logic_in_create_state
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation_rotation;
  final double rad = 20.0;
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation_rad
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Center(
        child: Stack(
          children: <Widget>[
            Dot(radius: 30.0, color: Colors.black12),
            Transform.translate(
              offset: Offset(rad * cos(pi), rad * sin(pi)),
              child: Dot(radius: 5, color: Colors.redAccent),
            ),
            Transform.translate(
              offset: Offset(rad * cos(2 * (pi / 4)), rad * sin(2 * (pi / 4))),
              child: Dot(radius: 5, color: Colors.redAccent),
            ),
            Transform.translate(
              offset: Offset(rad * cos(3 * (pi / 4)), rad * sin(3 * (pi / 4))),
              child: Dot(radius: 5, color: Colors.redAccent),
            ),
            Transform.translate(
              offset: Offset(rad * cos(4 * (pi / 4)), rad * sin(4 * (pi / 4))),
              child: Dot(radius: 5, color: Colors.redAccent),
            ),
            Transform.translate(
              offset: Offset(rad * cos(5 * (pi / 4)), rad * sin(5 * (pi / 4))),
              child: Dot(radius: 5, color: Colors.redAccent),
            ),
            Transform.translate(
              offset: Offset(rad * cos(6 * (pi / 4)), rad * sin(6 * (pi / 4))),
              child: Dot(radius: 5, color: Colors.redAccent),
            ),
            Transform.translate(
              offset: Offset(rad * cos(7 * (pi / 4)), rad * sin(7 * (pi / 4))),
              child: Dot(radius: 5, color: Colors.redAccent),
            ),
            Transform.translate(
              offset: Offset(rad * cos(2 * (pi / 4)), rad * sin(2 * (pi / 4))),
              child: Dot(radius: 5, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

// ignore: use_key_in_widget_constructors
  Dot({required this.radius, required this.color});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: this.radius,
        width: this.radius,
        decoration: BoxDecoration(
          color: this.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
