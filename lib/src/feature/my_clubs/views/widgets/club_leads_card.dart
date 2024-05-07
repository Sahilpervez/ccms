import 'package:ccms/src/res/assets.dart';
import 'package:flutter/material.dart';

class ClubLeadsCard extends StatelessWidget {
  const ClubLeadsCard({
    super.key,
    required this.name,
    required this.position,
    required this.constraints,
  });
  final BoxConstraints constraints;
  final String name;
  final String position;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (constraints.maxWidth / 2) - 5,
      decoration: ShapeDecoration(
        color: const Color(0xFFF4F9FD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      child: Column(
        children: [
          Container(
            height: (constraints.maxWidth / 2 - 5) * 0.4,
            width: (constraints.maxWidth / 2 - 5) * 0.4,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 209, 209, 209),
            ),
            child: const Center(
                child: Icon(
              Icons.person_outlined,
              size: 35,
              color: Color.fromARGB(255, 134, 134, 134),
            )),
          ),
          const SizedBox(height: 16),
          Text(
            name.substring(0,name.indexOf(" "))+ "\n" +name.substring(name.indexOf(" ")),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF0A1629),
              fontSize: 14,
              fontFamily: AssetFonts.nunitosans,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 3),
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff7D8592),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              position,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF7D8592),
                fontSize: 14,
                fontFamily: AssetFonts.nunitosans,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
