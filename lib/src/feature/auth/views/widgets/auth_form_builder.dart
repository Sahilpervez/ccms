import 'package:flutter/material.dart';
import 'auth_forrms_heading.dart';

class AuthFormBuilder extends StatelessWidget {
  const AuthFormBuilder({Key? key,required this.size, required this.authForm, required this.formTitle, required this.formSubtitle,this.backButton = false,this.backButtonFunction,this.extraheadings}) : super(key: key);
  final extraheadings;
  final Size size;
  final Widget authForm;
  final String formTitle;
  final String formSubtitle;
  final bool? backButton;
  final Function? backButtonFunction;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular((size.width < 520) ? 24 : 0),
                      topLeft: const Radius.circular(24),
                      bottomLeft: Radius.circular((size.width < 520) ? 0 : 24)),
                  color: Colors.white),
              height: constraints.maxHeight * 0.68,
              width: constraints.maxWidth,
              child: authForm,
            );
          }),
        ),
        AuthFormHeader(
          size: size,
          title: formTitle,
          subTitle: formSubtitle,
          extras: extraheadings,
        ),
        (backButton!)?Positioned(
          child: GestureDetector(
            onTap: () {
              (backButtonFunction != null)?backButtonFunction!():(){};
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              height: (size.width < 520) ? 40 : 20,
              width: (size.width < 520) ? 40 : 20,
              child: const Icon(
                Icons.keyboard_arrow_left_rounded,
                size: 15,
              ),
            ),
          ),
        ):Container(),
      ],
    );
  }
}