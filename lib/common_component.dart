import 'package:flutter/material.dart';

import 'constants.dart';

class CommonCalendar extends StatelessWidget {
  const CommonCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(primaryBlueColor),
          borderRadius: BorderRadius.all(Radius.circular(9))),
      width: 50,
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text("Dec", style: TextStyle(color: Colors.white)),
          Text("19", style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
