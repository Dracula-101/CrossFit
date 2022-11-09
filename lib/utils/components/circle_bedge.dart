import 'package:flutter/material.dart';

class CircleBadge extends StatelessWidget {
  final Color color;
  final String title, subtitle;

  // ignore: prefer_const_constructors_in_immutables
  CircleBadge(
      {super.key,
      required this.color,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: FittedBox(
        child: Column(
          children: <Widget>[
            Container(
              width: 45.0,
              height: 60.0,
              transform: Matrix4.translationValues(0.0, 102.0, 0.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: color,
              ),
              child: CustomPaint(
                size: const Size(50, 60),
                painter: TriangleClipper(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(
                  color: const Color.fromRGBO(231, 241, 248, 1.0),
                  width: 3.0,
                ),
              ),
              padding: const EdgeInsets.all(6.0),
              transform: Matrix4.translationValues(0.0, -30.0, 0.0),
              height: 110.0,
              width: 120.0,
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  border: Border.all(
                    color: const Color.fromRGBO(231, 241, 248, 1.0),
                    width: 3.0,
                  ),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        color:
                            (color != const Color.fromRGBO(255, 255, 255, 1.0))
                                ? Colors.white
                                : Colors.blue[100],
                        fontWeight: FontWeight.w900,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color:
                            (color != const Color.fromRGBO(255, 255, 255, 1.0))
                                ? Colors.white
                                : Colors.blue[100],
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomPainter {
  late Paint _paint;

  TriangleClipper() {
    _paint = Paint()
      ..color = const Color.fromRGBO(231, 241, 248, 1.0)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width / 2, size.height - 15.0);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
