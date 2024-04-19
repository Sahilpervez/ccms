
import 'package:ccms/src/res/assets.dart';
import 'package:ccms/src/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
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
            offset: Offset(0, 4)
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 0, right: 25),
                height: 50,
                width: 50,
                child: const ClipOval(
                  child: Image(
                      image: AssetImage(
                          ImageAssets.kiproject1)),
                ),
              ),
              SizedBox(
                width: constraints.maxWidth - 125,
                child: const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PN0001265",
                      style: TextStyle(
                        fontFamily: AssetFonts.nunitosans,
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        height: 1.7,
                      ),
                    ),
                    Text(
                      "Fluttering into Mobile App Development",
                      style: TextStyle(
                          fontFamily:
                              AssetFonts.nunitosans,
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          height: 1.1,
                          overflow:
                              TextOverflow.ellipsis),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.kiDrawerCalender,
                    ),
                    const SizedBox(width: 7),
                    SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: const Text(
                        'Created 11-04-2024',
                        style: TextStyle(
                          color: Color(0xFF7D8592),
                          fontSize: 15,
                          fontFamily:
                              AssetFonts.nunitosans,
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                Chip(
                  padding: const EdgeInsets.all(5),
                  backgroundColor: AppColors.kcChipColor,
                  label: const Text(
                    "2 Hrs",
                    style: TextStyle(
                        fontFamily: AssetFonts.nunitosans,
                        color: Colors.black,
                        fontSize: 12),
                  ),
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 0,
                        color: AppColors.kcThemeColor,
                      ),
                      borderRadius:
                          BorderRadius.circular(30)),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0,left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    Text(
                      'Participants',
                      style: TextStyle(
                        color: Color(0xFF91929E),
                        fontSize: 14,
                        fontFamily: AssetFonts.nunitosans,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '34',
                      style: TextStyle(
                        color: Color(0xFF0A1629),
                        fontSize: 16,
                        fontFamily: AssetFonts.nunitosans,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.5,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Chip(
                      padding: const EdgeInsets.all(5),
                      backgroundColor: AppColors.kcNamePlateColor,
                      label: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "GDSC",
                            style: TextStyle(
                                fontFamily: AssetFonts.nunitosans,
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Alam Sahilpervez",
                            style: TextStyle(
                                fontFamily: AssetFonts.nunitosans,
                                color: Colors.black,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 0,
                            color: AppColors.kcNamePlateBorderColor,
                          ),
                          borderRadius:BorderRadius.circular(15)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
