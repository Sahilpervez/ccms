import 'dart:math';

import 'package:flutter/material.dart';

class SignUpTab extends StatelessWidget {
  const SignUpTab({
    super.key,
    required this.size,
    required this.constraints, required this.signUpFunction,
  });

  final BoxConstraints constraints;
  final Function signUpFunction;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: min(200, constraints.maxWidth * 0.5),
          child: const Text(
            'Don’t have an account?',
            style: TextStyle(
              color: Color(0xFF646982),
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: (size.width > 500 && size.width < 550)
              ? 0
              : 15,
        ),
        InkWell(
          onTap: () {
            signUpFunction();
          },
          child: SizedBox(
            width: min(60, constraints.maxWidth * 0.19),
            child: const Text(
              'SIGN UP',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}