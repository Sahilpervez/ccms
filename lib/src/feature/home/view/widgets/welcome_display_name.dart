
import 'package:ccms/src/res/assets.dart';
import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

class WelcomeDisplayName extends StatelessWidget {
  const WelcomeDisplayName({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          top: 10,
          // bottom: 10,
        ),
        child: Text(
          'Welcome back, $name!',
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Color(0xFF7D8592),
            fontSize: 17,
            fontFamily: AssetFonts.nunitosans,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
