
import 'package:ccms/src/models/club.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:flutter/material.dart';

class ClubHeaderSection extends StatelessWidget {
  const ClubHeaderSection({
    super.key,
    required this.club,
    required this.inClubAsMember,
  });

  final Club club;
  final bool inClubAsMember;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                club.clubName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontFamily: AssetFonts.nunitosans,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: (inClubAsMember)?Colors.green:Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  (inClubAsMember)?"JOINED":"JOIN",
                  style: TextStyle(
                      fontFamily: AssetFonts.nunitosans,
                      fontWeight: FontWeight.w600),
                )),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1AC3CBD6),
                blurRadius: 30,
                offset: Offset(0, 6),
                spreadRadius: 0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Text(club.clubDescription),
        ),
      ],
    );
  }
}
