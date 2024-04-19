
import 'package:ccms/src/res/assets.dart';
import 'package:flutter/material.dart';


class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
    required this.header,
  });

  final String header;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          // bottom: 20,
          bottom: 5,
        ),
        child: Text(
          header,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Color(0xFF0A1629),
            fontSize: 36,
            fontFamily: AssetFonts.nunitosans,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
