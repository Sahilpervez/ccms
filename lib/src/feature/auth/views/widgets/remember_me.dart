import 'dart:math';

import 'package:flutter/material.dart';

class RememberMeBox extends StatelessWidget {
  const RememberMeBox({Key? key, required this.rememberMe,required this.toogleRem,required this.constraints}) : super(key: key);

  final rememberMe;
  final Function toogleRem;
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: rememberMe,
          onChanged: (val) {
            toogleRem();
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(
                color:
                Color.fromRGBO(227, 235, 242, 1),
                width: 5,
              )),
          side: BorderSide(
            color: (rememberMe)
                ? Colors.black
                : const Color.fromRGBO(
                227, 235, 242, 1),
            width: 2,
          ),
          activeColor:
          const Color.fromRGBO(227, 235, 242, 1),
          checkColor: Colors.black,
        ),
        InkWell(
          onTap: () {
            toogleRem();
          },
          child: SizedBox(
            width:
            min(100, constraints.maxWidth * 0.26),
            child: const Text(
              "Remember Me",
              style:
              TextStyle(color: Color(0xff7E8A97)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}