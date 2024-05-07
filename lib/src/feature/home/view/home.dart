import 'dart:developer';

import 'package:ccms/src/feature/home/view/widgets/custom_app_bar.dart';
import 'package:ccms/src/feature/home/view/widgets/date_bar.dart';
import 'package:ccms/src/feature/home/view/widgets/event_card.dart';
import 'package:ccms/src/feature/home/view/widgets/event_type_selector.dart';
import 'package:ccms/src/feature/home/view/widgets/screen_header.dart';
import 'package:ccms/src/feature/home/view/widgets/welcome_display_name.dart';
import 'package:ccms/src/global/controller/events_controller.dart';
import 'package:ccms/src/global/providers/common_providers.dart';
import 'package:ccms/src/global/views/custom_app_drawer.dart';
import 'package:ccms/src/models/events.dart';
import 'package:ccms/src/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key, this.getUser = false}) : super(key: key);

  static const routePath = "/home";
  final bool getUser;

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final scrollController = ScrollController();

  Set<EventType> selectedEventType = {EventType.allEvent};
  List<Event>? events = [];

  void onOptionsChange(Set<EventType> p0) {
    setState(() {
      selectedEventType.clear();
      selectedEventType.addAll(p0);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(eventsControllerProvider.notifier).getEventsFromRepo();
  }

  // List<int> events = [1, 2, 3, 4, 5, 6, 7];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final eventsList = ref.watch(eventsControllerProvider);
    final isLoading = ref.watch(eventsControllerProvider.notifier).isLoading;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.6,
      backgroundColor: AppColors.kcAppBackgroundColor,
      drawer: CustomAppDrawer(size: size, cntxt: context),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              if (isLoading)
                Column(children: [
                  const SizedBox(height: 100),
                  const WelcomeDisplayName(name: "Sahilpervez"),
                  const ScreenHeader(header: "Dashboard"),
                  DateBar(constraints: constraints),
                  // SectionHeadings(heading: "Projects", viewMoreFunction: () {}),
                  EventTypeSelector(
                      selectedEventType: selectedEventType,
                      onSelectionChanged: onOptionsChange),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      child: const Center(
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ]),
              if (isLoading == false && eventsList.isEmpty)
                const Center(
                  child: Text("Error Loading Data"),
                ),
              if (eventsList.isNotEmpty)
                ListView.builder(
                  itemCount: eventsList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(children: [
                        const SizedBox(height: 100),
                        const WelcomeDisplayName(name: "Sahilpervez"),
                        const ScreenHeader(header: "Dashboard"),
                        DateBar(constraints: constraints),
                        // SectionHeadings(heading: "Projects", viewMoreFunction: () {}),
                        EventTypeSelector(
                            selectedEventType: selectedEventType,
                            onSelectionChanged: onOptionsChange),
                        const SizedBox(height: 10),
                      ]);
                    }
                    if (index != 0) {
                      return LayoutBuilder(builder: (context, constraints) {
                        return EventCard(
                            constraints: constraints,
                            currentEvent: eventsList[index - 1]);
                      });
                    }
                  },
                ),
              
              // FutureBuilder(
              //   future: ref
              //       .read(eventsControllerProvider.notifier)
              //       .getEventsFromRepo(context: context),
              //   builder: (context, snapshot) {
              //     final data = snapshot.data;
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       // return const Center(
              //       //   child: CircularProgressIndicator(),
              //       // );
              //       return Column(children: [
              //         const SizedBox(height: 100),
              //         const WelcomeDisplayName(name: "Sahilpervez"),
              //         const ScreenHeader(header: "Dashboard"),
              //         DateBar(constraints: constraints),
              //         // SectionHeadings(heading: "Projects", viewMoreFunction: () {}),
              //         EventTypeSelector(
              //             selectedEventType: selectedEventType,
              //             onSelectionChanged: onOptionsChange),
              //         const SizedBox(height: 10),
              //         Expanded(
              //           child: Container(
              //             child: const Center(
              //               child: const CircularProgressIndicator(),
              //             ),
              //           ),
              //         ),
              //       ]);
              //     }
              //     if (snapshot.hasError) {
              //       return const Center(
              //         child: Text("Error Loading Data"),
              //       );
              //     }
              //     if (snapshot.connectionState == ConnectionState.done) {
              //       if (data != null) {
              //         return ListView.builder(
              //           itemCount: data.length + 1,
              //           itemBuilder: (context, index) {
              //             if (index == 0) {
              //               return Column(children: [
              //                 const SizedBox(height: 100),
              //                 const WelcomeDisplayName(name: "Sahilpervez"),
              //                 const ScreenHeader(header: "Dashboard"),
              //                 DateBar(constraints: constraints),
              //                 // SectionHeadings(heading: "Projects", viewMoreFunction: () {}),
              //                 EventTypeSelector(
              //                     selectedEventType: selectedEventType,
              //                     onSelectionChanged: onOptionsChange),
              //                 const SizedBox(height: 10),
              //               ]);
              //             }
              //             if (index != 0) {
              //               return LayoutBuilder(
              //                   builder: (context, constraints) {
              //                 return EventCard(
              //                     constraints: constraints,
              //                     currentEvent: data[index - 1]);
              //               });
              //             }
              //           },
              //         );
              //         // Column(
              //         //   children: [
              //         //     const SizedBox(height: 100),
              //         //     const WelcomeDisplayName(name: "Sahilpervez"),
              //         //     const ScreenHeader(header: "Dashboard"),
              //         //     DateBar(constraints: constraints),
              //         //     // SectionHeadings(heading: "Projects", viewMoreFunction: () {}),
              //         //     EventTypeSelector(
              //         //         selectedEventType: selectedEventType,
              //         //         onSelectionChanged: onOptionsChange),
              //         //     const SizedBox(height: 10),
              //         //     if (data != null && data!.isNotEmpty)
              //         //       Expanded(
              //         //         child: ListView.builder(
              //         //           itemCount: data.length,
              //         //           itemBuilder: (context, index) {
              //         //             return LayoutBuilder(
              //         //                 builder: (context, constraints) {
              //         //               return EventCard(constraints: constraints);
              //         //             });
              //         //           },
              //         //         ),
              //         //       ),
              //         //     // ...data!.map(
              //         //     //   (e) {
              //         //     //     return LayoutBuilder(
              //         //     //         builder: (context, constraints) {
              //         //     //       return EventCard(constraints: constraints);
              //         //     //     });
              //         //     //   },
              //         //     // )
              //         //   ],
              //         // );
              //       } else {
              //         return const Center(
              //           child: Text("Error Loading Data"),
              //         );
              //       }
              //     }
              //     return const Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   },
              // ),
              
              Positioned(
                top: 10,
                child: CustomAppBar(
                  context: context,
                  constraints: constraints,
                  disablePop: true,
                  leadingActionIcon: const Icon(Icons.menu),
                  scaffoldKey: _scaffoldKey,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
