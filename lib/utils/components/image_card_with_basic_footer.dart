import 'package:crossfit/models/workout/exercise.model.dart';
import 'package:flutter/material.dart';

class ImageCardWithBasicFooter extends StatelessWidget {
  final Exercise exercise;
  final String tag;
  final double imageWidth;

  const ImageCardWithBasicFooter({super.key, 
    required this.exercise,
    required this.tag,
    required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
          tag: tag,
          child: Container(
            width: imageWidth ,
            height: 160.0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
              image: DecorationImage(
                image: AssetImage(exercise.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          width: imageWidth,
          margin: const EdgeInsets.only(top: 10.0),
          child: Text(
            exercise.title,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 14.0),
          ),
        ),
        Container(
          width: imageWidth,
          margin: const EdgeInsets.only(top: 5.0),
          child: Text(
            '${exercise.time}    |    ${exercise.difficult}',
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
