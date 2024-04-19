
import 'package:flutter/material.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DateBar extends StatelessWidget {
  const DateBar({
    super.key,
    required this.constraints,
  });
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(top: 5,
            left: 15, right: 15, bottom: 10),
        padding:
            const EdgeInsets.only(top: 12, bottom: 12, left: 16),
        width: constraints.maxWidth,
        height: 48,
        decoration: ShapeDecoration(
          color: const Color(0xFFE6ECF4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: SvgPicture.asset(ImageAssets.klcalanderIcon,),
          ),
          Text(
            '${DateFormat("MMMM dd, yyyy").format(DateTime.now())} - ${DateFormat("MMMM yyyy").format(DateTime(DateTime.now().year,DateTime.now().month + 1))}',
            style: const TextStyle(
              color: Color(0xFF0A1629),
              fontSize: 16,
              fontFamily: AssetFonts.nunitosans,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],),
      ),
    );
  }
}

