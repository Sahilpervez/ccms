import 'package:ccms/src/feature/all_clubs/views/all_clubs_screen.dart';
import 'package:ccms/src/feature/calendar/views/calendar_screen.dart';
import 'package:ccms/src/feature/home/view/home.dart';
import 'package:ccms/src/feature/my_clubs/views/my_clubs_screen.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final customAppDrawerRepoProvider =
    StateProvider<CustomAppDrawerRepo>((ref) => CustomAppDrawerRepo());

class CustomAppDrawerRepo {
  final activeColor = const Color(0xffE78175);
  final inactiveColor = const Color(0xff7D8592);
  int activeIdx = 0;
  CustomAppDrawerRepo({
    this.activeIdx = 0,
  });
  setActiveIdx(int index){
    activeIdx = index;
  }
  final screens = [
    {
      "name": "Dashboard",
      "icon": ImageAssets.kiDrawerDashboard,
      "routes" : HomeView.routePath,
    },
    {
      "name": "All Clubs",
      "icon": ImageAssets.kiDrawerProjects,
      "routes" : AllClubsScreen.routePath,
    },
    {
      "name": "My Clubs",
      "icon": ImageAssets.kiDrawerLeads,
      "routes" : MyClubsScreen.routePath,
    },
    {
      "name": "Calendar",
      "icon": ImageAssets.kiDrawerCalender,
      "routes" : CalendarScreen.routePath,
    },

    // {
    //   "name": "Messenger",
    //   "icon": ImageAssets.kiDrawerMessenger,
    //   "routes" : MessengerScreen.routePath,
    // },


    // {
    //   "name": "Leaves",
    //   "icon": ImageAssets.kiDrawerLeaves,
    //   "routes" : LeavesScreen.routePath,
    // },
    // {
    //   "name": "Leads",
    //   "icon": ImageAssets.kiDrawerLeads,
    //   "routes" : LeadsScreen.routePath,
    // },
    // {
    //   "name": "Portal",
    //   "icon": ImageAssets.kiDrawerProtal,
    //   "routes" : PortalScreen.routePath,
    // },
    // {
    //   "name": "Clients",
    //   "icon": ImageAssets.kiDrawerClients,
    //   "routes" : ClientsScreen.routePath,
    // },
    // {
    //   "name": "FAQs",
    //   "icon": ImageAssets.kiDrawerFAQs,
    //   "routes" : FaqView.routePath,
    // },
    // {
    //   "name": "About Us",
    //   "icon": ImageAssets.kiDrawerAboutUs,
    //   "routes" : AboutUsScreen.routePath,
    // },
  ];

  CustomAppDrawerRepo copyWith({
    int? activeIdx,
  }) {
    return CustomAppDrawerRepo(
      activeIdx: activeIdx ?? this.activeIdx,
    );
  }
}
