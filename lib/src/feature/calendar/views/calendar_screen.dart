import 'package:ccms/src/feature/calendar/views/widgets/calendar_event_list_item.dart';
import 'package:ccms/src/feature/home/view/widgets/custom_app_bar.dart';
import 'package:ccms/src/feature/home/view/widgets/setctions_headings.dart';
import 'package:ccms/src/global/controller/events_controller.dart';
import 'package:ccms/src/global/widgets/scroll_parent.dart';
import 'package:ccms/src/models/events.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:ccms/src/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  static const routePath = "/calender";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends ConsumerState<CalendarScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  final ScrollController _screenScrollController = ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); 

  Map<DateTime, List<Event>>? selectedEvents;

  List<Event> _getDateEvents(DateTime datevalue) {
    DateTime date = datevalue;
    date = date.copyWith(
        hour: 0, minute: 0, second: 0, microsecond: 0, millisecond: 0);
    return selectedEvents![date] ?? [];
  }

  @override
  void initState() {
    selectedEvents = {};

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allEvents = ref.watch(eventsControllerProvider);
    selectedEvents = {};
    allEvents.forEach(
      (element) {
        final date = element.eventDate.copyWith(
            hour: 0, minute: 0, second: 0, microsecond: 0, millisecond: 0);
        if (selectedEvents![date] == [] || selectedEvents![date] == null) {
          selectedEvents![date] = [];
          selectedEvents![date]?.add(element);
        } else {
          selectedEvents![date]?.add(element);
        }
      },
    );
    // final size = MediaQuery.of(context).size;
    final eventsToShow = _getDateEvents(selectedDay);
    return Scaffold(
      backgroundColor: AppColors.kcAppBackgroundColor,
      floatingActionButton: InkWell(
        onTap: () async {
          // await showDialog(
          //     barrierDismissible: true,
          //     context: context,
          //     builder: (ctx) {
          //       return AddEvent(
          //         size: size,
          //         ctx: ctx,
          //       );
          //     });
          // setState(() {});
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: const ShapeDecoration(
            color: Color(0xFFE78175),
            shape: OvalBorder(),
            shadows: [
              BoxShadow(
                color: Color(0x433F8CFF),
                blurRadius: 12,
                offset: Offset(0, 6),
                spreadRadius: 0,
              )
            ],
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                controller: _screenScrollController,
                child: Column(
                  children: [
                    Container(height: constraints.maxHeight * 0.17),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                      child: SectionHeadings(
                        heading: "Calendar",
                        viewMoreFunction: () {},
                        headingFontSize: 36,
                        displayViewMore: false,
                      ),
                    ),
                    ScrollParent(
                      controller: _screenScrollController,
                      child: SingleChildScrollView(
                        child: Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            height: 450,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24)),
                              border: Border.all(
                                width: 0.2,
                                color: Colors.grey,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 10,
                                    offset: const Offset(0, 4)),
                              ],
                            ),
                            child: TableCalendar(
                              focusedDay: focusedDay,
                              firstDay: DateTime.now().copyWith(year: 2000),
                              lastDay: DateTime.now().copyWith(year: 3000),
                              headerStyle: calendarHeaderStyle(),
                              // Events
                              eventLoader: _getDateEvents,
                              calendarBuilders: CalendarBuilders(
                                markerBuilder:
                                    (BuildContext context, date, events) {
                                  if (events.isEmpty) return const SizedBox();
                                  return Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    padding: const EdgeInsets.all(1),
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      width: 7,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // Calendar styling
                              calendarStyle: CalendarStyle(
                                defaultTextStyle: const TextStyle(
                                  color: Color(0xFF202860),
                                  fontSize: 14,
                                  fontFamily: AssetFonts.nunitosans,
                                  fontWeight: FontWeight.w400,
                                ),
                                holidayDecoration: const BoxDecoration(
                                  color: Colors.amber,
                                ),
                                cellMargin:
                                    const EdgeInsets.symmetric(vertical: 2),
                                isTodayHighlighted: true,
                                selectedTextStyle: const TextStyle(
                                  color: Color(0xFF202860),
                                  fontSize: 14,
                                  fontFamily: AssetFonts.nunitosans,
                                  fontWeight: FontWeight.w400,
                                ),
                                selectedDecoration: ShapeDecoration(
                                  color: (selectedDay.day ==
                                              DateTime.now().day &&
                                          selectedDay.month ==
                                              DateTime.now().month &&
                                          selectedDay.year ==
                                              DateTime.now().year)
                                      ? const Color.fromARGB(255, 255, 203, 198)
                                      : null,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1, color: Colors.blue),
                                    borderRadius: BorderRadius.circular(7),
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
                                todayTextStyle: const TextStyle(
                                  color: Color(0xFF202860),
                                  fontSize: 14,
                                  fontFamily: AssetFonts.nunitosans,
                                  fontWeight: FontWeight.w400,
                                ),
                                todayDecoration: ShapeDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 203, 198),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
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
                              ),
                              daysOfWeekHeight: 30,
                              daysOfWeekStyle: daysOfWeekStyle2(),
                              // Day Change
                              onDaySelected: (selectDay, focusDay) {
                                setState(() {
                                  focusedDay = focusDay;
                                  selectedDay = selectDay;
                                });
                              },
                              selectedDayPredicate: (day) {
                                return isSameDay(selectedDay, day);
                              },

                              startingDayOfWeek: StartingDayOfWeek.monday,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24)),
                          border: Border.all(
                                width: 0.2,
                                color: Colors.grey,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 10,
                                    offset: const Offset(0, 4)),
                              ],
                        ),
                        child: ScrollParent(
                          controller: _screenScrollController,
                          child: SingleChildScrollView(
                            child: Column(children: [
                              Row(
                                children: [
                                  Text(
                                    DateFormat("MMMM d , yyyy").format(selectedDay),
                                    style: const TextStyle(
                                      color: Color(0xFF0A1629),
                                      fontSize: 17,
                                      fontFamily: AssetFonts.nunitosans,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 16,
                              ),
                              if (eventsToShow.isEmpty)
                                const Text(
                                  "No Events Scheduled",
                                  style: TextStyle(
                                    color: Color(0xFF0A1629),
                                    fontSize: 20,
                                    fontFamily: AssetFonts.nunitosans,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ...eventsToShow
                                  .map(
                                    (e) => CalendarEventListItem(
                                      constraints: constraints,
                                      event: e,
                                    ),
                                  )
                                  .toList(),
                            ]),
                          ),
                        )),
                    Container(height: 30),
                  ],
                ),
              ),
              Positioned(
                  top: 10,
                  child:
                      CustomAppBar(context: context, constraints: constraints,scaffoldKey: _scaffoldKey,)),
            ],
          );
        }),
      ),
    );
  }

  DaysOfWeekStyle daysOfWeekStyle2() {
    return DaysOfWeekStyle(
      decoration: BoxDecoration(
        color: const Color(0xffF4F9FD),
        borderRadius: BorderRadius.circular(7),
      ),
      weekendStyle: const TextStyle(
        color: Color(0xFFe78175),
        fontSize: 14,
        fontFamily: AssetFonts.nunitosans,
        fontWeight: FontWeight.w600,
      ),
      weekdayStyle: const TextStyle(
        color: Color(0xFF7D8592),
        fontSize: 14,
        fontFamily: AssetFonts.nunitosans,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  HeaderStyle calendarHeaderStyle() {
    return const HeaderStyle(
      formatButtonVisible: false,
      titleCentered: true,
      titleTextStyle: TextStyle(
        color: Color(0xFF0A1629),
        fontSize: 18,
        fontFamily: AssetFonts.nunitosans,
        fontWeight: FontWeight.w700,
      ),
      rightChevronIcon: Icon(
        Icons.arrow_forward_rounded,
        color: Color(0xffE78175),
      ),
      leftChevronIcon: Icon(
        Icons.arrow_back_rounded,
        color: Color(0xffE78175),
      ),
    );
  }
}
