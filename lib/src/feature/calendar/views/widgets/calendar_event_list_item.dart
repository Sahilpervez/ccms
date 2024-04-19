
import 'package:ccms/src/models/events.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:flutter/material.dart';


class CalendarEventListItem extends StatelessWidget {
  const CalendarEventListItem({
    super.key,
    required this.constraints,
    required this.event,
  });

  final BoxConstraints constraints;
  final Event event;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(8),
        height: 75,
        decoration: ShapeDecoration(
          color: const Color(0xFFF4F9FD),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.eventTitle,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Color(0xFF0A1629),
                      fontSize: 14,
                      fontFamily: AssetFonts.nunitosans,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '\t${"${event.eventTime.hour}h ${event.eventTime.minute % 60}m"}\t',
                        style: const TextStyle(
                          color: Color(0xFF7D8592),
                          fontSize: 13,
                          fontFamily: AssetFonts.nunitosans,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      // Icon(
                      //   (event.priority == "Low")
                      //       ? Icons.arrow_downward_rounded
                      //       : Icons.arrow_upward_rounded,
                      //   color: (event.priority == "Low")
                      //       ? Colors.green
                      //       : Colors.amber,
                      // ),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
