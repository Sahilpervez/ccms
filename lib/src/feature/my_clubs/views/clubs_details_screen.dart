import 'dart:math';

import 'package:ccms/src/feature/all_clubs/controller/clubs_controller.dart';
import 'package:ccms/src/feature/home/view/widgets/custom_app_bar.dart';
import 'package:ccms/src/feature/my_clubs/views/widgets/club_header_section.dart';
import 'package:ccms/src/feature/my_clubs/views/widgets/club_leads_card.dart';
import 'package:ccms/src/feature/my_clubs/views/widgets/event_short_items.dart';
import 'package:ccms/src/global/controller/events_controller.dart';
import 'package:ccms/src/global/providers/common_providers.dart';
import 'package:ccms/src/global/views/create_event_screen.dart';
import 'package:ccms/src/models/club.dart';
import 'package:ccms/src/models/events.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:ccms/src/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ClubsDetailsScreen extends ConsumerStatefulWidget {
  const ClubsDetailsScreen({super.key, required this.club});
  static const String routePath = "/clubs_details_screen";
  final Club club;

  @override
  ConsumerState<ClubsDetailsScreen> createState() => _ClubsDetailsScreenState();
}

class _ClubsDetailsScreenState extends ConsumerState<ClubsDetailsScreen> {
  bool _isLoading = false;

  late Club _currentClub;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentClub = widget.club;
    _getClubById();
  }

  void _getClubById() async {
    setState(() {
      _isLoading = true;
    });
    await ref
        .read(clubsControllerProvider.notifier)
        .getClubById(clubId: _currentClub.clubId, context: context)
        .then(
      (value) {
        if (value != null) {
          _currentClub = value;
        }
      },
    );
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          (element.toString().substring(element.toString().indexOf('.') + 1)) ==
          _currentClub.clubName.toLowerCase().replaceAll(".", ""),
    );
    final inClubAsTeam = ([...(userData?.inClubAsTeam ?? [])]).any(
      (element) =>
          (element.toString().substring(element.toString().indexOf('.') + 1)) ==
          _currentClub.clubName.toLowerCase().replaceAll(".", ""),
    );

    return Scaffold(
      backgroundColor: AppColors.kcAppBackgroundColor,
      floatingActionButton: (inClubAsTeam)
          ? IconButton(
              onPressed: () {
                context.push(CreateEventScreen.routePath,
                    extra: {"clubId": _currentClub.clubId});
              },
              icon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.add, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 120),
                    // Club Header :
                    ClubHeaderSection(
                      club: _currentClub,
                      inClubAsMember: inClubsAsMember,
                    ),
                    // Event List Title :
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 20),
                      child: Text(
                        "Events",
                        style: TextStyle(
                          fontFamily: AssetFonts.nunitosans,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    // Event List :
                    Consumer(builder: (context, ref, _) {
                      final events = ref.watch(eventsControllerProvider);
                      final eventsIsLoading = ref
                          .watch(eventsControllerProvider.notifier)
                          .isLoading;
                      return Container(
                        height: max(200 - 20, size.height * 0.28 - 20),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: Align(
                            child: Scrollbar(
                              child: ListView(
                                // padding: const EdgeInsets.only(left: 20),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  if (eventsIsLoading && events.isEmpty)
                                    const CircularProgressIndicator(),
                                  if (events.isNotEmpty)
                                    ...(events.where(
                                      (element) {
                                        return element.clubId ==
                                            _currentClub.clubId;
                                      },
                                    ).toList())
                                        .map((e) =>
                                            EventsShortItems(size: size, e: e))
                                        .toList(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    if (_isLoading) const CircularProgressIndicator(),
                    // Club Leads Section :
                    if (!_isLoading)
                      Container(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 10, right: 10, left: 10),
                        width: size.width,
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
                            )
                          ],
                        ),
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 12, bottom: 20),
                                child: Text(
                                  'Leads',
                                  style: TextStyle(
                                    color: Color(0xFF0A1629),
                                    fontSize: 18,
                                    fontFamily: AssetFonts.nunitosans,
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  ClubLeadsCard(
                                    name: _currentClub.clubPresident ??
                                        "Alam Sahipervez",
                                    position: "President",
                                    constraints: constraints,
                                  ),
                                  const SizedBox(width: 10),
                                  ClubLeadsCard(
                                    name: _currentClub.clubVicePresident ??
                                        "Alam Sahipervez",
                                    position: "Vice Prez.",
                                    constraints: constraints,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  ClubLeadsCard(
                                    name: _currentClub.clubSecretary ??
                                        "Alam Sahipervez",
                                    position: "Secretary",
                                    constraints: constraints,
                                  ),
                                  const SizedBox(width: 10),
                                  ClubLeadsCard(
                                    name: _currentClub.clubTreasurer ??
                                        "Alam Sahipervez",
                                    position: "Treasurer",
                                    constraints: constraints,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  ClubLeadsCard(
                                    name: "Alam Sahipervez",
                                    position: "Executive",
                                    constraints: constraints,
                                  ),
                                  const SizedBox(width: 10),
                                  ClubLeadsCard(
                                    name: "John Doe",
                                    position: "Executive",
                                    constraints: constraints,
                                  ),
                                ],
                              ),
                              
                            ],
                          );
                        }),
                      ),
                      const SizedBox(height: 100),
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

