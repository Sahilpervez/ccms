import 'package:ccms/src/feature/auth/views/widgets/common_button.dart';
import 'package:ccms/src/feature/home/view/widgets/custom_app_bar.dart';
import 'package:ccms/src/global/views/custom_app_drawer.dart';
import 'package:ccms/src/models/events.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:ccms/src/res/constants.dart';
import 'package:ccms/src/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class EventDetailsScreen extends ConsumerWidget {
  EventDetailsScreen({super.key, required this.currentEvent});
  static const String routePath = "/event_details_screen";
  final Event currentEvent;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        key: _scaffoldKey,
        drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.6,
        backgroundColor: AppColors.kcAppBackgroundColor,
        drawer: CustomAppDrawer(cntxt: context,size: size,),
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(height: 120),
                      InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: Icon(Icons.arrow_back_outlined,
                                  color: AppColors.kcThemeColor),
                            ),
                            Text(
                              'Back to Home',
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 10),
                        child: Text(
                          /// TODO : Change this to default currentEvent.eventTitle later
                          currentEvent.eventTitle.replaceFirst(
                              currentEvent.eventTitle[0],
                              currentEvent.eventTitle[0].toUpperCase()),
                          style: const TextStyle(
                            color: Color(0xFF0A1629),
                            fontSize: 22,
                            fontFamily: AssetFonts.nunitosans,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        width: size.width,
                        // height: 578,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 22),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1AC3CBD6),
                              blurRadius: 58,
                              offset: Offset(0, 6),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 2.0),
                              child: Text(
                                'Event ID',
                                style: AppStyles.eventDetailsTitleStyle,
                              ),
                            ),
                            Text(
                              'PN00AZ0${currentEvent.eventId}',
                              style: AppStyles.eventDetailsValueStyle,
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'Description',
                              style: AppStyles.eventDetailsDescriptionHeading,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${currentEvent.eventDescription}',
                              style: AppStyles.eventDetailsDescriptionBody,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  ImageAssets.kiDrawerCalender,
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  UtilFunctions.formattedDate(
                                      currentEvent.eventDate,
                                      monthFormat: "MMMM"),
                                  style: const TextStyle(
                                    color: Color(0xFF7D8592),
                                    fontSize: 16,
                                    fontFamily: AssetFonts.nunitosans,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  softWrap: true,
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),

                            /// Venue
                            const Text("Venue",
                                style: AppStyles.eventDetailsTitleStyle),
                            const SizedBox(height: 1),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.location_on_rounded,
                                    color: Color(0xff7D8592)),
                                const SizedBox(height: 10),
                                Flexible(
                                  child: Text(currentEvent.eventLocation,
                                      style: AppStyles.eventDetailsValueStyle
                                          .copyWith(height: 1.3)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),

                            /// Organizers
                            const Text("Clubs",
                                style: AppStyles.eventDetailsTitleStyle),
                            Text(
                                currentEvent.organizingClubs?.join(', ') ??
                                    "GDSC, CoLD",
                                style: AppStyles.eventDetailsValueStyle),
                            const SizedBox(height: 15),
                            /// Organizers
                            const Text("Organizer",
                                style: AppStyles.eventDetailsTitleStyle),
                            Text(
                                currentEvent.organizingStudent ??
                                    "Alam Sahilpervez",
                                style: AppStyles.eventDetailsValueStyle),
                            // const SizedBox(height: 20),
                            // const Text("Date",
                            //     style: AppStyles.eventDetailsTitleStyle),
                            // const SizedBox(height: 2),
                            // Text(
                            //     UtilFunctions.formattedDate(
                            //         currentEvent.eventDate),
                            //     style: AppStyles.eventDetailsValueStyle),
                            // const SizedBox(height: 21),
                          ],
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: size.width * 0.8,
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: ShapeDecoration(
                      color: AppColors.kcThemeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x433F8CFF),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Enroll",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: AssetFonts.nunitosans,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  child: CustomAppBar(
                    context: context,
                    constraints: constraints,
                    disablePop: true,
                    leadingActionIcon: const Icon(Icons.menu_rounded),
                    scaffoldKey: _scaffoldKey,
                  ),
                ),
              ],
            );
          }),
        ));
  }
}
