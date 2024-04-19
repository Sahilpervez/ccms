
import 'package:ccms/src/res/assets.dart';
import 'package:flutter/material.dart';

class SectionHeadings extends StatelessWidget {
  const SectionHeadings({
    super.key,
    required this.heading,
    this.viewMoreColor,
    required this.viewMoreFunction,
    this.topSpacing = 0,
    this.headingFontSize =22,
    this.displayViewMore = true,
    this.textFontStyle=AssetFonts.nunitosans,
  });

  final String heading;
  final Color? viewMoreColor;
  final Function viewMoreFunction;
  final double topSpacing;
  final double headingFontSize;
  final bool displayViewMore;
  final String textFontStyle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: topSpacing,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                heading,
                style: TextStyle(
                  color: const Color(0xFF0A1629),
                  fontSize: headingFontSize,
                  fontFamily: AssetFonts.nunitosans,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if(displayViewMore)
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: InkWell(
                onTap:(){
                  viewMoreFunction();
                },
                child: Row(
                  children: [
                    Text(
                      "View all",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: (viewMoreColor == null)
                            ? const Color(0xFFE78175)
                            : viewMoreColor,
                        fontSize: 16,
                        fontFamily: textFontStyle,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded,
                        color: (viewMoreColor == null)
                            ? const Color(0xFFE78175)
                            : viewMoreColor),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
