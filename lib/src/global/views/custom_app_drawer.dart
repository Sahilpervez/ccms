import 'package:ccms/src/feature/auth/views/enrollment_screen.dart';
import 'package:ccms/src/feature/home/view/home.dart';
import 'package:ccms/src/global/controller/events_controller.dart';
import 'package:ccms/src/global/controller/shared_prefs_controller.dart';
import 'package:ccms/src/global/providers/common_providers.dart';
import 'package:ccms/src/global/repo/app_drawer.dart';
import 'package:ccms/src/global/widgets/app_drawer_menus.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:ccms/src/res/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

class CustomAppDrawer extends ConsumerWidget {
  const CustomAppDrawer({super.key, required this.size, required this.cntxt});

  final Size size;
  final BuildContext cntxt;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(customAppDrawerRepoProvider);
    final size = MediaQuery.sizeOf(context);
    return Drawer(
      width: size.width * 0.7,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(24), bottomRight: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 15),
          // child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DottedBorder(
                strokeWidth: 1,
                color: AppColors.kcThemeColor,
                borderType: BorderType.RRect,
                strokeCap: StrokeCap.round,
                radius: const Radius.circular(20),
                dashPattern: const [7],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.kcChipColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ClipOval(
                          child: Image(
                            image: AssetImage(ImageAssets.kLeadProfilePic1),
                            height: 80,
                            width: 80,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("Alam Sahilpervez",
                            style: TextStyle(
                                fontFamily: AssetFonts.nunitosans,
                                fontWeight: FontWeight.w700,
                                fontSize: 20)),
                        Text("alamsa48_soe",
                            style: TextStyle(
                                fontFamily: AssetFonts.nunitosans,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(flex: 2, child: Container()),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  children: [
                    ...data.screens
                        .mapWithIndex(
                          (t, index) => InkWell(
                            onTap: () {
                              print(index);
                              ref
                                  .watch(customAppDrawerRepoProvider.notifier)
                                  .update((state) =>
                                      state = state.copyWith(activeIdx: index));
                              context.pop();
                              // if(t['routes'] as String == LeavesScreen.routePath)
                              // {
                              //   showDialog(context: context, builder: (context){
                              //     return LeavesScreen();
                              //   });
                              // }
                              // else
                              if (t['routes'] as String != HomeView.routePath) {
                                context.push(t['routes'] as String);
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 7.0),
                              child: AppDrawerMenus(
                                  data: data, index: index, t: t),
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
              // Expanded(flex: 1, child: Container()),

              // THIS OPTION WILL BE INCLUDED LATER :
              // SupportButtton(cntxt: cntxt, size: size),

              Expanded(flex: 10, child: Container()),
              InkWell(
                onTap: () {
                  if (kDebugMode) {
                    print("Logout Pressed");
                  }
                  ref.read(eventsControllerProvider).clear();
                  ref.read(sharedPrefsControllerPovider).clear();
                  ref.read(authTokenProvider.notifier).update((state) => null);
                  ref.read(currentUserProvider.notifier).update((state) => null);
                  context.go(EnrollmentScreen.routePath);
                },
                child: const SizedBox(
                  width: 140,
                  height: 80,
                  // margin: const EdgeInsets.only(left: 8),
                  // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          Icons.logout_rounded,
                          color: Color(0xFF7D8592),
                          size: 30,
                        ),
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Color(0xFF7D8592),
                          fontSize: 20,
                          fontFamily: AssetFonts.nunitosans,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          // ),
        ),
      ),
    );
  }
}
