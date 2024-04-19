import 'package:ccms/src/feature/home/view/widgets/custom_app_bar.dart';
import 'package:ccms/src/feature/home/view/widgets/screen_header.dart';
import 'package:ccms/src/global/repo/app_drawer.dart';
import 'package:ccms/src/models/enums.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:ccms/src/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class AllClubsScreen extends ConsumerStatefulWidget {
  const AllClubsScreen({super.key});
  static const routePath = "/allClubs";

  @override
  ConsumerState<AllClubsScreen> createState() => _MyClubsScreenState();
}

class _MyClubsScreenState extends ConsumerState<AllClubsScreen> {
  Set<ClubType> selectedCategory = {ClubType.technical};
  void onPop() {
    ref
        .read(customAppDrawerRepoProvider.notifier)
        .update((state) => state = state.copyWith(activeIdx: 0));
    context.pop();
  }

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final clubs = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    return Scaffold(
      // key: _scaffoldKey,
      // drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.6,
      backgroundColor: AppColors.kcAppBackgroundColor,
      // drawer: CustomAppDrawer(size: size, cntxt: context),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              ListView(
                // padding: EdgeInsets.symmetric(horizontal: 12,),
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  InkWell(
                    onTap: () {
                      // context.pop();
                      onPop();
                    },
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12.0, right: 7),
                          child: Icon(Icons.arrow_back_outlined,
                              color: AppColors.kcThemeColor),
                        ),
                        Text(
                          'Back to Dashboard',
                          style: TextStyle(
                            color: AppColors.kcThemeColor,
                            fontSize: 16,
                            fontFamily: AssetFonts.nunitosans,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        )
                      ],
                    ),
                  ),
                  const ScreenHeader(header: "All Clubs"),
                  Align(
                    child: SegmentedButton(
                      multiSelectionEnabled: true,
                      segments: const [
                        ButtonSegment(
                          value: ClubType.technical,
                          label: Text(
                            "Technical",
                            style: TextStyle(
                                fontFamily: AssetFonts.nunitosans,
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ButtonSegment(
                          value: ClubType.cultural,
                          label: Text(
                            "Cultural",
                            style: TextStyle(
                                fontFamily: AssetFonts.nunitosans,
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                      style: SegmentedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          selectedBackgroundColor: AppColors.kcChipColor),
                      selected: selectedCategory,
                      onSelectionChanged: (p0) {
                        setState(() {
                          selectedCategory = p0;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 0.2,
                        color: Colors.grey,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 10,
                            offset: Offset(0, 4)),
                      ],
                    ),
                    child: Stack(
                      children: [
                        SizedBox(height: 120,)
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                  top: 10,
                  child: CustomAppBar(
                    context: context,
                    constraints: constraints,
                    disablePop: false,
                  )),
            ],
          );
        }),
      ),
    );
  }
}
