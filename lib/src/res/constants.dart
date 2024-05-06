import 'package:ccms/src/res/assets.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const kcAuthThemeColor = Color.fromRGBO(57, 89, 152, 1);
  static const kcBackgroundColor = Colors.white;
  static const kcAppBackgroundColor = Color(0xFFF4F9FD);
  static const kcThemeColor = Color(0xffE78175);
  static const kcChipColor = Color.fromARGB(255, 255, 211, 206);

  static const kcNamePlateColor = Color.fromARGB(255, 216, 235, 250);
  static const kcNamePlateBorderColor = Color.fromARGB(255, 148, 198, 236);
}

class AppStyles {
  static const TextStyle eventDetailsTitleStyle = TextStyle(
    color: Color(0xFF91929E),
    fontSize: 14,
    fontFamily: AssetFonts.nunitosans,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle eventDetailsValueStyle = TextStyle(
    color: Color(0xFF0A1629),
    fontSize: 16,
    fontFamily: AssetFonts.nunitosans,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle eventDetailsDescriptionHeading = TextStyle(
    color: Color(0xFF0A1629),
    fontSize: 16,
    fontFamily: AssetFonts.nunitosans,
    fontWeight: FontWeight.w700,
  );
  static TextStyle eventDetailsDescriptionBody = TextStyle(
    color: const Color(0xFF0A1629).withOpacity(0.7),
    fontSize: 16,
    fontFamily: AssetFonts.nunitosans,
    fontWeight: FontWeight.w400,
  );
}
