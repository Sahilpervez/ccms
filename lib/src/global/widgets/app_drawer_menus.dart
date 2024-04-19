import 'package:ccms/src/global/repo/app_drawer.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppDrawerMenus extends StatelessWidget {
  const AppDrawerMenus({
    super.key,
    required this.data,
    required this.index,required this.t
  });

  final CustomAppDrawerRepo data;
  final int index;
  final Map<String, String> t;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10),
            height: 55,
            decoration: BoxDecoration(
                color: (data.activeIdx == index)
                    ? const Color.fromARGB(
                            255, 245, 145, 134)
                        .withOpacity(0.1)
                    : Colors.transparent,
                borderRadius:
                    BorderRadius.circular(10)),
            child: Row(
              children: [
                Container(
                  height: 27,width: 27,
                  child: SvgPicture.asset(
                    t['icon'] as String,
                    color: (data.activeIdx == index)
                        ? data.activeColor
                        : data.inactiveColor,
                        fit:BoxFit.fitHeight
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  t['name'] as String,
                  style: TextStyle(
                    color: (data.activeIdx == index)
                        ? data.activeColor
                        : data.inactiveColor,
                    fontSize: 19,
                    fontFamily: AssetFonts.nunitosans,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        (data.activeIdx == index)
            ? Container(
                margin: const EdgeInsets.only(left: 12),
                width: 5,
                decoration: BoxDecoration(
                    color: data.activeColor,
                    borderRadius:
                        BorderRadius.circular(5)),
                height: 55,
              )
            : Container(),
      ],
    );
  }
}
