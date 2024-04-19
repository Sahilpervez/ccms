
import 'package:ccms/src/res/assets.dart';
import 'package:ccms/src/res/constants.dart';
import 'package:flutter/material.dart';

enum EventType {
  allEvent,
  myEvent,
  upcomingEvent,
}

class EventTypeSelector extends StatelessWidget {
  const EventTypeSelector(
      {super.key,
      required this.selectedEventType,
      required this.onSelectionChanged});

  final Set<EventType> selectedEventType;
  final Function(Set<EventType>) onSelectionChanged;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SegmentedButton(
        multiSelectionEnabled: true,
        showSelectedIcon: false,
        segments: const [
          ButtonSegment(
            value: EventType.allEvent,
            label: Text(
              "All Events",
              style: TextStyle(
                  fontFamily: AssetFonts.nunitosans,
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
          ButtonSegment(
            value: EventType.myEvent,
            label: Text(
              "My Events",
              style: TextStyle(
                  fontFamily: AssetFonts.nunitosans,
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
          ButtonSegment(
            value: EventType.upcomingEvent,
            label: Text(
              "Upcoming\nEvents",
              style: TextStyle(
                  fontFamily: AssetFonts.nunitosans,
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        ],
        selected: selectedEventType,
        style: SegmentedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          selectedBackgroundColor: AppColors.kcChipColor
        ),
        onSelectionChanged: onSelectionChanged,
      ),
    );
  }
}
