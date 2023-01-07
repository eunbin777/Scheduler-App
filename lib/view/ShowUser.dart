import 'package:flutter/material.dart';

class ShowUser extends StatelessWidget {
  final String user;

  const ShowUser(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;

    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(
            right: 20.0,
          ),
          child: const CircleAvatar(
            backgroundImage: AssetImage('images/user.png'),
            backgroundColor: Colors.white,
          ),
        ),
        Text(
          user,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
