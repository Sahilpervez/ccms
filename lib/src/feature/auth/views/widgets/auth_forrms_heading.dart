import 'package:flutter/material.dart';
import 'package:ccms/src/res/assets.dart';

class AuthFormHeader extends StatelessWidget {
  const AuthFormHeader({
    super.key,
    required this.size, required this.title, required this.subTitle, this.extras,
  });

  final extras;
  final Size size;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: (size.width < 520)
          ? Alignment.topCenter
          : Alignment.centerLeft,
      child: SizedBox(
        width: (size.width < 520) ? size.width : size.width * 0.4,
        child: Column(
          mainAxisAlignment: (size.width < 520)
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.12),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: (size.width < 520) ? 25 : 30,
                  fontFamily: AssetFonts.roboto),
            ),
            SizedBox(
              width: (size.width < 520)
                  ? size.width * 0.9
                  : size.width * 0.3,
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: AssetFonts.roboto,
                  fontSize: (size.width < 520) ? 14 : 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            if(extras!=null)
              ...extras
          ],
        ),
      ),
    );
  }
}