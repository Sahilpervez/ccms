import 'package:ccms/src/global/repo/app_drawer.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar(
      {super.key,
      required this.context,
      required this.constraints,
      this.leadingActionIcon,
      this.scaffoldKey ,
      this.disablePop = false});

  final BuildContext context;
  final BoxConstraints constraints;
  final bool disablePop;
  final Widget? leadingActionIcon;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.topCenter,
      width: constraints.maxWidth - 20,
      height: 70,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x1AC3CBD6),
            blurRadius: 58,
            offset: Offset(0, 6),
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.only(right: 20, left: 10),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                if (!disablePop) {
                  ref
                      .read(customAppDrawerRepoProvider.notifier)
                      .update((state) => state = state.copyWith(activeIdx: 0));
                  context.pop();
                }else if(leadingActionIcon != null){
                  scaffoldKey!.currentState!.openDrawer();
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 45,
                width: 45,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF5F6FA),
                ),
                child: Center(
                  child: leadingActionIcon ??
                      Icon(
                        Icons.arrow_back_rounded,
                        color: Color.fromRGBO(29, 30, 32, 1),
                      ),
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      ImageAssets.klsearchIcon,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return NotificationsBuilder(constraints: constraints);
                    //     });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      ImageAssets.klnotificationsIcon,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // context.push(ProfileView.routePath);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      ImageAssets.klsettingsIcon,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
