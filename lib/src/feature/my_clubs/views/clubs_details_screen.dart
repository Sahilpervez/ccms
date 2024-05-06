import 'package:ccms/src/feature/home/view/widgets/custom_app_bar.dart';
import 'package:ccms/src/feature/my_clubs/views/widgets/club_header_section.dart';
import 'package:ccms/src/global/providers/common_providers.dart';
import 'package:ccms/src/global/views/create_event_screen.dart';
import 'package:ccms/src/models/club.dart';
import 'package:ccms/src/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ClubsDetailsScreen extends ConsumerWidget {
  const ClubsDetailsScreen({super.key, required this.club});
  static const String routePath = "/clubs_details_screen";
  final Club club;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final userData = ref.read(currentUserProvider);
    print("MEMBERS IN CLUB${[
      ...(userData?.inClubAsMember ?? []),
      ...(userData?.inClubAsTeam ?? [])
    ]}");
    final inClubsAsMember = ([
          ...(userData?.inClubAsMember ?? []),
          ...(userData?.inClubAsTeam ?? [])
        ]).any(
          (element) =>
              (element
                  .toString()
                  .substring(element.toString().indexOf('.') + 1)) ==
              club.clubName.toLowerCase().replaceAll(".", ""),
        );
    final inClubAsTeam = ([...(userData?.inClubAsTeam ?? [])]).any(
          (element) =>
              (element
                  .toString()
                  .substring(element.toString().indexOf('.') + 1)) ==
              club.clubName.toLowerCase().replaceAll(".", ""),
        );
    return Scaffold(
      backgroundColor: AppColors.kcAppBackgroundColor,
      floatingActionButton: (inClubAsTeam)
          ? IconButton(
              onPressed: () {
                context.push(CreateEventScreen.routePath);
              },
              icon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.add),
              ),
              style: ElevatedButton.styleFrom(
                iconColor: Colors.white,
                backgroundColor: AppColors.kcThemeColor,
              ))
          : null,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Column(
                  children: [
                    const SizedBox(height: 120),
                    ClubHeaderSection(
                      club: club,
                      inClubAsMember: inClubsAsMember,
                    ),
                  ],
                ),
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
