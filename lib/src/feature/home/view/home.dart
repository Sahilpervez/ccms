import 'package:ccms/src/feature/home/view/widgets/custom_app_bar.dart';
import 'package:ccms/src/feature/home/view/widgets/date_bar.dart';
import 'package:ccms/src/feature/home/view/widgets/event_card.dart';
import 'package:ccms/src/feature/home/view/widgets/event_type_selector.dart';
import 'package:ccms/src/feature/home/view/widgets/screen_header.dart';
import 'package:ccms/src/feature/home/view/widgets/welcome_display_name.dart';
import 'package:ccms/src/global/providers/common_providers.dart';
import 'package:ccms/src/global/views/custom_app_drawer.dart';
import 'package:ccms/src/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routePath = "/home";

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final scrollController = ScrollController();

  Set<EventType> selectedEventType = {EventType.allEvent};

  void onOptionsChange(Set<EventType> p0) {
    setState(() {
      selectedEventType.clear();
      selectedEventType.addAll(p0);
    });
  }

  List<int> events = [1, 2, 3, 4, 5, 6, 7];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey(); 

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authToken = ref.read(authTokenProvider);
    print(authToken);
    return Scaffold(
      key: _scaffoldKey,
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.6,
      backgroundColor: AppColors.kcAppBackgroundColor,
      drawer: CustomAppDrawer(size: size, cntxt: context),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    const WelcomeDisplayName(name: "Sahilpervez"),
                    const ScreenHeader(header: "Dashboard"),
                    DateBar(constraints: constraints),
                    // SectionHeadings(heading: "Projects", viewMoreFunction: () {}),
                    EventTypeSelector(selectedEventType: selectedEventType,
                        onSelectionChanged: onOptionsChange),
                    const SizedBox(height: 10),
                    ...events.map(
                      (e) {
                        return LayoutBuilder(builder: (context, constraints) {
                          return EventCard(constraints: constraints);
                        });
                      },
                    )
                  ],
                ),
              ),
              Positioned(
                  top: 10,
                  child: CustomAppBar(
                    context: context,
                    constraints: constraints,
                    disablePop: true,
                    leadingActionIcon: Icon(Icons.menu),
                    scaffoldKey : _scaffoldKey,
                  )),
            ],
          );
        }),
      ),
    );
  }
}