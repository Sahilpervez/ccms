import 'package:ccms/src/feature/my_clubs/views/clubs_details_screen.dart';
import 'package:ccms/src/models/club.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClubCard extends StatelessWidget {
  const ClubCard({
    super.key,
    required this.club,
  });
  final Club club;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(ClubsDetailsScreen.routePath, extra: {"club": club});
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              club.clubName,
              style: const TextStyle(
                fontSize: 25,
                fontFamily: AssetFonts.nunitosans,
                fontWeight: FontWeight.w700,
                color: Color(0xff0A1629),
              ),
            ),
            Text(
              club.clubDescription,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: AssetFonts.nunitosans,
                fontWeight: FontWeight.w500,
                color: Color(0xff0A1629),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            Row(
              children: [
                const Text(
                  "Event Count : ",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: AssetFonts.nunitosans,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff0A1629),
                  ),
                ),
                Text(
                  club.eventCount.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: AssetFonts.nunitosans,
                    color: Color(0xff0A1629),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
