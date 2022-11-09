import 'package:flutter/material.dart';

class UserPhoto extends StatelessWidget {
  const UserPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54.0,
      height: 54.0,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(
            'assets/images/exercise/image009.jpg',
          ),
          fit: BoxFit.fill,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(360),
        ),
        color: Colors.redAccent,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 20.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
        border: Border.all(
          color: Colors.white,
          width: 4.0,
        ),
      ),
    );
  }
}
