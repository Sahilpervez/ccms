import 'package:ccms/src/models/events.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsShortItems extends StatelessWidget {
  const EventsShortItems({
    super.key,
    required this.size,
    required this.e,
  });

  final Size size;
  final Event e;
  final Duration eventDuration = const Duration(
    hours: 2,
    minutes: 26,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, top: 10, bottom: 15),
      width: size.width * 0.75,
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
              spreadRadius: 0)
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: constraints.maxHeight,
              width: 5,
              decoration: BoxDecoration(
                color: (e.eventDate.isAfter(DateTime.now()))
                    ? Colors.green
                    : Colors.amber.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 16,
                top: 5,
              ),
              width: constraints.maxWidth - 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        // width: constraints.maxWidth * 0.75,
                        width: constraints.maxWidth - 21,
                        child: Text(
                          e.eventTitle,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Color(0xFF0A1629),
                              fontSize: 16,
                              fontFamily: AssetFonts.nunitosans,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      // Icon(
                      //   (e.priority == "Low")
                      //       ? Icons.arrow_downward_rounded
                      //       : Icons.arrow_upward_rounded,
                      //   color:
                      //       (e.priority == "Low") ? Colors.green : Colors.amber,
                      //   size: 30,
                      // )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${(DateTime(e.eventDate.year, e.eventDate.month, e.eventDate.day) == DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)) ? "Today" : (DateTime(e.eventDate.year, e.eventDate.month, e.eventDate.day) == DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)) ? "Tomorrow" : DateFormat("MMM dd").format(e.eventDate)} | ${e.eventTime.format(context)}',
                        style: const TextStyle(
                          color: Color(0xFF91929E),
                          fontSize: 14,
                          fontFamily: AssetFonts.nunitosans,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        decoration: BoxDecoration(
                            color: const Color(0xffF4F9FD),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time_filled,
                                color: Color(0xff7D8592)),
                            Text(
                              '\t${(eventDuration < const Duration(hours: 1)) ? "${eventDuration.inMinutes}m" : "${eventDuration.inHours}h"}',
                              style: const TextStyle(
                                color: Color(0xFF7D8592),
                                fontSize: 12,
                                fontFamily: AssetFonts.nunitosans,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
