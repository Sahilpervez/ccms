import 'package:ccms/src/feature/all_clubs/controller/clubs_controller.dart';
import 'package:ccms/src/feature/all_clubs/views/widgets/club_card.dart';
import 'package:ccms/src/feature/home/view/widgets/custom_app_bar.dart';
import 'package:ccms/src/feature/home/view/widgets/screen_header.dart';
import 'package:ccms/src/global/providers/common_providers.dart';
import 'package:ccms/src/global/repo/app_drawer.dart';
import 'package:ccms/src/models/club.dart';
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
  final clubs = [];

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final size = MediaQuery.of(context).size;
    final userData = ref.read(currentUserProvider)?.inClubAsTeam;
    print(userData);
    return Scaffold(
      // key: _scaffoldKey,
      // drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.6,
      backgroundColor: AppColors.kcAppBackgroundColor,
      // drawer: CustomAppDrawer(size: size, cntxt: context),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              FutureBuilder(
                future: ref
                    .read(clubsControllerProvider.notifier)
                    .getClubsFromRepo(context: context),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // return const Center(
                    //   child: CircularProgressIndicator(),
                    // );
                    return Column(children: [
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
                      Expanded(
                        child: Container(
                          child: const Center(
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ]);
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error Loading Data"),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (data != null) {
                      clubs.clear();
                      clubs.addAll(data);
                      return ListView.builder(
                        itemCount: data.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(children: [
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
                                      padding:
                                          EdgeInsets.only(left: 12.0, right: 7),
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
                                      selectedBackgroundColor:
                                          AppColors.kcChipColor),
                                  selected: selectedCategory,
                                  onSelectionChanged: (p0) {
                                    setState(() {
                                      selectedCategory = p0;
                                    });
                                  },
                                ),
                              ),
                            ]);
                          }
                          if (index != 0 &&
                              selectedCategory.contains(ClubType.technical)) {
                            return LayoutBuilder(
                                builder: (context, constraints) {
                              return ClubCard(club: data[index - 1]);
                            });
                          }
                          if (index != 0 &&
                              selectedCategory.length == 1 &&
                              selectedCategory.contains(ClubType.cultural)) {
                            if (index == 1) {
                              return Image.asset(
                                  'assets/images/notavailable.png');
                            } else {
                              return SizedBox();
                            }
                          }
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("Error Loading Data"),
                      );
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
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
