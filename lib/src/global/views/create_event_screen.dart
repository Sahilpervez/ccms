import 'package:ccms/src/feature/home/view/widgets/custom_app_bar.dart';
import 'package:ccms/src/global/controller/events_controller.dart';
import 'package:ccms/src/global/providers/common_providers.dart';
import 'package:ccms/src/models/events.dart';
import 'package:ccms/src/res/assets.dart';
import 'package:ccms/src/res/constants.dart';
import 'package:ccms/src/utils/snackbar_service.dart';
import 'package:ccms/src/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  const CreateEventScreen({super.key,required this.clubId});
  static const String routePath = "/create_event_screen";
  final int clubId;

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _eventLocationController =
      TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _descriptionController.dispose();
    _eventLocationController.dispose();
    super.dispose();
  }

  void _createEvent(WidgetRef ref) async {
    if (_descriptionController.text.isNotEmpty &&
        _eventLocationController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        selectedDate != null &&
        selectedTime != null) {
      final currentStudent = ref.read(currentUserProvider);
      final currentEvent = Event(eventTitle: _nameController.text,eventDescription: _descriptionController.text, eventLocation: _eventLocationController.text,createdBy: currentStudent!.enrollmentNumber,clubId: widget.clubId,eventDate: selectedDate!, eventTime: selectedTime!, createdOn: DateTime.now(), lastModifiedOn: DateTime.now());
      _isLoading = true;
      await ref.read(eventsControllerProvider.notifier).addEvents(event: currentEvent, context: context);
      _isLoading = false;
    } else {
      SnackBarService.showSnackBar(
          context: context, message: "Enter all the fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kcAppBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 120),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                            "Add Event",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: AssetFonts.nunitosans,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 1, color: const Color(0xFFE78175)),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x3FC3C3C3),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(ImageAssets.kiDrawerCalender,
                                  color: const Color(0xFFE78175)),
                              const Text(
                                'Event Calendar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFD7776C),
                                  fontSize: 12,
                                  fontFamily: AssetFonts.nunitosans,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 6.0, bottom: 2),
                      child: Text(
                        'Event Name',
                        style: TextStyle(
                          color: Color(0xFF7D8592),
                          fontSize: 14,
                          fontFamily: AssetFonts.nunitosans,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      style: const TextStyle(
                        color: Color(0xff0A1629),
                        fontFamily: AssetFonts.nunitosans,
                        fontSize: 15,
                      ),
                      cursorColor: AppColors.kcThemeColor,
                      decoration: InputDecoration(
                        hintText: "Enter the Title of your Event",
                        hintStyle: const TextStyle(
                          color: Color(0xFF7D8592),
                          fontSize: 14,
                          fontFamily: AssetFonts.nunitosans,
                          fontWeight: FontWeight.w400,
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFFD8E0EF)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFFD8E0EF)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              width: 1, color: AppColors.kcThemeColor),
                        ),
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, left: 6.0, bottom: 2),
                      child: Text(
                        'Description',
                        style: TextStyle(
                          color: Color(0xFF7D8592),
                          fontSize: 14,
                          fontFamily: AssetFonts.nunitosans,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 5,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      style: const TextStyle(
                        color: Color(0xff0A1629),
                        fontFamily: AssetFonts.nunitosans,
                        fontSize: 15,
                      ),
                      cursorColor: AppColors.kcThemeColor,
                      decoration: InputDecoration(
                        hintText: "Enter the Description of your Event",
                        hintStyle: const TextStyle(
                          color: Color(0xFF7D8592),
                          fontSize: 14,
                          fontFamily: AssetFonts.nunitosans,
                          fontWeight: FontWeight.w400,
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFFD8E0EF)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFFD8E0EF)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              width: 1, color: AppColors.kcThemeColor),
                        ),
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, left: 6.0, bottom: 2),
                      child: Text(
                        'Venue',
                        style: TextStyle(
                          color: Color(0xFF7D8592),
                          fontSize: 14,
                          fontFamily: AssetFonts.nunitosans,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextFormField(
                      scrollPadding: const EdgeInsets.only(bottom: 200),
                      controller: _eventLocationController,
                      maxLines: 3,
                      cursorColor: AppColors.kcThemeColor,
                      style: const TextStyle(
                        color: Color(0xff0A1629),
                        fontFamily: AssetFonts.nunitosans,
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter the Venue of your Event",
                        hintStyle: const TextStyle(
                          color: Color(0xFF7D8592),
                          fontSize: 14,
                          fontFamily: AssetFonts.nunitosans,
                          fontWeight: FontWeight.w400,
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFFD8E0EF)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFFD8E0EF)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              width: 1, color: AppColors.kcThemeColor),
                        ),
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, left: 6.0, bottom: 2),
                      child: Text(
                        'Date',
                        style: TextStyle(
                          color: Color(0xFF7D8592),
                          fontSize: 14,
                          fontFamily: AssetFonts.nunitosans,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)));
                        setState(() {});
                        FocusScope.of(context).unfocus();
                      },
                      child: Container(
                        width: size.width,
                        height: 60,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFD8E0EF)),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x38B7C8E0),
                              blurRadius: 2,
                              offset: Offset(0, 1),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 12),
                        child: Row(
                          children: [
                            Text(
                              (selectedDate == null)
                                  ? 'Select Date'
                                  : UtilFunctions.formattedDate(selectedDate!,
                                      monthFormat: "MMMM"),
                              style: (selectedDate != null)
                                  ? const TextStyle(
                                      color: Color(0xff0A1629),
                                      fontFamily: AssetFonts.nunitosans,
                                      fontSize: 15,
                                    )
                                  : const TextStyle(
                                      color: Color(0xFF7D8592),
                                      fontSize: 14,
                                      fontFamily: AssetFonts.nunitosans,
                                      fontWeight: FontWeight.w400,
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, left: 6.0, bottom: 2),
                      child: Text(
                        'Time',
                        style: TextStyle(
                          color: Color(0xFF7D8592),
                          fontSize: 14,
                          fontFamily: AssetFonts.nunitosans,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        selectedTime = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        setState(() {});
                      },
                      child: Container(
                        width: size.width,
                        height: 60,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFD8E0EF)),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x38B7C8E0),
                              blurRadius: 2,
                              offset: Offset(0, 1),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 12),
                        child: Row(
                          children: [
                            Text(
                              (selectedTime == null)
                                  ? 'Select Time'
                                  : "${selectedTime!.hour}:${selectedTime!.minute}",
                              style: (selectedTime != null)
                                  ? const TextStyle(
                                      color: Color(0xff0A1629),
                                      fontFamily: AssetFonts.nunitosans,
                                      fontSize: 15,
                                    )
                                  : const TextStyle(
                                      color: Color(0xFF7D8592),
                                      fontSize: 14,
                                      fontFamily: AssetFonts.nunitosans,
                                      fontWeight: FontWeight.w400,
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 10,
                  child: CustomAppBar(
                    context: context,
                    constraints: constraints,
                    disablePop: false,
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    _createEvent(ref);
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 20),
                    width: size.width * 0.8,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFE78175),
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
                    child:(_isLoading) ?const Center(child: CircularProgressIndicator()):const Center(
                      child: Text(
                        'Save Event',
                        textAlign: TextAlign.center,
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
              ),
            ],
          );
        }),
      ),
    );
  }
}
