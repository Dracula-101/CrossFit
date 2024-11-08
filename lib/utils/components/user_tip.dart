import 'package:flutter/material.dart';

class UserTip extends StatelessWidget {
  final String image;
  final String name;

  UserTip({
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 15.0,
        top: 10.0,
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 105,
            height: 105,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(this.image),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(360.0),
              ),
              border: Border.all(
                color: Colors.white,
                width: 7.0,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Text(
              this.name,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
