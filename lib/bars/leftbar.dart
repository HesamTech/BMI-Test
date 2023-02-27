import 'package:flutter/material.dart';

class LeftBar extends StatelessWidget {
  final double barWidth;
  const LeftBar({
    Key? key,
    required this.barWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 25,
          width: barWidth,
          decoration: const BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }
}
