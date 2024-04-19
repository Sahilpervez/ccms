import 'package:ccms/src/res/assets.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  CommonButton(
      {super.key,
      required this.size,
      required this.onTap,
      required this.text,
      this.isOutlined = false,
      this.outlinedColor,
      this.isLoading,this.width});

  final Function onTap;
  final String? text;
  final Size size;
  final bool isOutlined;
  final Color? outlinedColor;
  final bool? isLoading;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onPressed: () {
        onTap();
      },
      child: Container(
        width: width??size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: ShapeDecoration(
          color: (isOutlined)
              ? Colors.white
              : const Color.fromARGB(255, 45, 177, 247),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: (isOutlined)
                ? BorderSide(
                    width: 2,
                    color: (outlinedColor != null)
                        ? outlinedColor!
                        : const Color.fromARGB(255, 45, 177, 247))
                : BorderSide.none,
          ),
          shadows: (isOutlined != true)
              ? [
                    BoxShadow(
                        color: Colors.blue.shade200,
                        spreadRadius: 0.7,
                        blurRadius: 5,
                        offset: const Offset(0, 2))
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: (isLoading != true)
                  ? Text(
                      text!.toUpperCase(),
                      style: TextStyle(
                        color: (isOutlined && outlinedColor != null)
                            ? outlinedColor
                            : (isOutlined)
                                ? const Color.fromARGB(255, 45, 177, 247)
                                : Colors.white,
                        fontSize: 14,
                        fontFamily: AssetFonts.inter,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : const Center(
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ))),
            ),
          ],
        ),
      ),
    );
  }
}
