import 'package:flutter/material.dart';
import 'package:ccms/src/res/assets.dart';

class AuthFormButton extends StatelessWidget {
  const AuthFormButton({
    super.key,
    required this.constraints,
    required this.text,
    this.buttonColor = Colors.black,
    required this.onPressed,
  });
  final BoxConstraints constraints;
  final String text;
  final buttonColor;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: constraints.maxWidth,
        height: 62,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: AssetFonts.roboto,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}